class Task < ApplicationRecord
  has_many :user_tasks
  has_many :users, through: :user_tasks
  belongs_to :subject

  scope :filter_by_name, ->(name) { where('"tasks"."name" ilike ?', "%#{name}%")}
  scope :filter_by_description, ->(description) { where('"tasks"."description" ilike ?', "%#{description}%") }
  scope :filter_by_subject, ->(subject) { joins(:subject).where('"subjects"."name" ilike ?', "%#{subject}%") }
  # scope :filter_by_team, ->(team) { joins(:subject).joins(:team).where('"teams"."name" ilike ?', "%#{team}%") }
  # scope :filter_by_team, ->(team) { includes(:team).where('"teams"."name" ilike ?', "%#{team}%") }
  scope :filter_by_team, ->(team) { joins(subject: :team).where('"teams"."name" ilike ?', "%#{team}%") }
end
