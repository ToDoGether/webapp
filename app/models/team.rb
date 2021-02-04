class Team < ApplicationRecord
  has_many :team_users
  has_many :subjects
  has_many :users, through: :team_users
  accepts_nested_attributes_for :subjects, :allow_destroy => true
  accepts_nested_attributes_for :team_users
end
