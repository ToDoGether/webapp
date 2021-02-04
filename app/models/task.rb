class Task < ApplicationRecord
  include Filterable
  has_many :user_tasks
  has_many :users, through: :user_tasks
  belongs_to :subject

  has_many :attachments
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  has_many :weblinks
  accepts_nested_attributes_for :weblinks, :allow_destroy => true

  # scope :filter_by_title, ->(title) { where('"tasks"."name" ilike ?', "%#{title}%")}
  # scope :filter_by_description, ->(description) { where('"tasks"."description" ilike ?', "%#{description}%") }
  scope :filter_by_subject, ->(subject) { joins(:subject).where('"subjects"."name" ilike ?', "%#{subject}%") }
  scope :filter_by_team, ->(team) { joins(subject: :team).where('"teams"."name" ilike ?', "%#{team}%") }
  scope :filter_by_status, ->(status) {
    status = '1, 2' if status.blank?
    status = '1, 2, 3' if status == '4'
    joins(:user_tasks).where("user_tasks.status IN ( #{status} )")
  }
  scope :filter_by_fulltext, ->(fulltext) {
    where("tasks.name ilike '%#{fulltext}%' OR
           tasks.description ilike '%#{fulltext}%' OR
           subjects.name ilike '%#{fulltext}%' OR
           teams.name ilike '%#{fulltext}%'"
    )
  }

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
