class Task < ApplicationRecord
  include Filterable
  has_many :user_tasks
  has_many :users, through: :user_tasks
  belongs_to :subject

  has_many :attachments
  has_many :weblinks

  scope :filter_by_title, ->(title) { where('"tasks"."name" ilike ?', "%#{title}%")}
  scope :filter_by_description, ->(description) { where('"tasks"."description" ilike ?', "%#{description}%") }
  scope :filter_by_subject, ->(subject) { joins(:subject).where('"subjects"."name" ilike ?', "%#{subject}%") }
  scope :filter_by_team, ->(team) { joins(subject: :team).where('"teams"."name" ilike ?', "%#{team}%") }
  scope :filter_by_search, ->(search) { where('"tasks"."name" ilike ? OR "tasks"."description" ilike ?', "%#{search}%", "%#{search}%") }

  def get_worktype_name
    case worktype
    when 1
      "Single"
    when 2
      "Group"
    else
      "Other"
    end
  end

  def is_groupwork
    worktype != 1
  end
end
