class Team < ApplicationRecord
  has_many :team_users
  has_many :subjects
  has_many :users, through: :team_users
  accepts_nested_attributes_for :subjects, :allow_destroy => true
  accepts_nested_attributes_for :team_users

  validates :name, uniqueness: true, presence: true, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: 'only allows letters and numbers' }
end
