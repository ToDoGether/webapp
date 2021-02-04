class Task < ApplicationRecord
  include Filterable
  has_many :user_tasks
  has_many :users, through: :user_tasks
  belongs_to :subject
  has_rich_text :description

  has_many_attached :attachments
  has_many :weblinks
  accepts_nested_attributes_for :weblinks, :allow_destroy => true

  validates :name, presence: true
  validates :duedate, presence: true

  scope :filter_by_subject, ->(subject) { joins(:subject).where('"subjects"."name" ilike ?', "%#{subject}%") }
  scope :filter_by_team, ->(team) { joins(subject: :team).where('"teams"."name" ilike ?', "%#{team}%") }
  scope :filter_by_status, ->(status) {
    status = '1, 2' if status.blank?
    status = '1, 2, 3' if status == '4'
    joins(:user_tasks).where("user_tasks.status IN ( #{status} )")
  }
  scope :filter_by_fulltext, ->(fulltext) {
    where(
      "tasks.name ilike '%#{fulltext}%' OR
      subjects.name ilike '%#{fulltext}%' OR
      teams.name ilike '%#{fulltext}%'"
    )
  }
  scope :filter_by_duedate_min, ->(duedate) {
    duedate = Date.today - 14 if duedate.blank?
    where('"tasks"."duedate" > ?', "#{duedate}") unless duedate.nil?
  }
  scope :filter_by_duedate_max, ->(duedate) { where('"tasks"."duedate" < ?', "#{duedate}") unless duedate.nil? }

  def get_worktype_name
    worktype ? "Together in a group" : "On your own"
  end

  def is_groupwork
    worktype == true
  end

  def formatted_duedate
    duedate.strftime("%A, %d.%m.%y")
  end
end
