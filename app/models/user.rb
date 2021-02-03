class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :team_users
  has_many :teams, through: :team_users

  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  has_many :subjects, -> { order(:name).distinct }, through: :teams

  def is_any_admin?
    team_users.where(is_admin: true).any?
  end
end
