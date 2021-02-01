class Task < ApplicationRecord
  has_many :user_tasks
  has_many :users, through: :user_tasks
  belongs_to :subject

  scope :filter_by_name, ->(name) { where('name ilike ?', "%#{name}%")}
  scope :filter_by_description, ->(description) { where('description ilike ?', "%#{description}%") }
  scope :filter_by_subject, ->(subject) { Task.joins(:subject).where('"subjects"."name" ilike ?', "%#{subject}%") }
end
