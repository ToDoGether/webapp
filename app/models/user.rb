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

  def admin_subjects
    subjects = []
    admin_teams.each do |team|
      subjects += team.subjects
    end
    subjects
  end

  def admin_teams
    teams.where(id: admin_team_ids)
  end

  def admin_team_ids
    admin_team_users.map(&:team_id)
  end

  def is_any_admin?
    admin_team_users.any?
  end

  private

  def admin_team_users
    team_users.where(is_admin: true)
  end
end
