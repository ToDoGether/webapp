# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # team_users
  has_many :team_users
  has_many :admin_team_users, -> { where is_admin: true }, class_name: 'TeamUser'

  # teams
  has_many :teams, through: :team_users
  has_many :admin_teams,
           through: :admin_team_users,
           class_name: 'Team',
           source: :team

  # subjects
  has_many :subjects, -> { order(:name).distinct }, through: :teams
  has_many :admin_subjects, -> { order(:name).distinct }, through: :admin_teams, source: :subjects

  # user_tasks
  has_many :user_tasks

  # tasks
  has_many :tasks, through: :user_tasks

  def is_team_admin?(team)
    admin_teams.include?(team)
  end

  def is_task_admin?(task)
    is_team_admin?(task.subject.team)
  end

  def has_team?(team)
    teams.include?(team)
  end

  def has_task?(task)
    has_team?(task.subject.team)
  end
end
