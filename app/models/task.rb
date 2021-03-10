# frozen_string_literal: true

class Task < ApplicationRecord
  include Filterable
  has_many :user_tasks
  has_many :users, through: :user_tasks

  belongs_to :subject
  delegate :color, :name, :team_name, to: :subject, prefix: true

  has_rich_text :description

  has_many_attached :attachments
  has_many :weblinks
  accepts_nested_attributes_for :weblinks, allow_destroy: true
  accepts_nested_attributes_for :user_tasks

  validates :name, presence: true
  validates :duedate, presence: true

  scope :filter_by_subject, lambda { |subject|
                              subject = '%' if subject.blank?
                              joins(:subject).where('subjects.name ilike ?', subject.to_s)
                            }

  scope :filter_by_team, lambda { |team|
                           team = '%' if team.blank?
                           joins(subject: :team).where('teams.name ilike ?', team.to_s)
                         }

  scope :filter_by_fulltext, lambda { |fulltext|
    fulltext.gsub!(/[^A-Za-z0-9\säöüÄÖÜß]/u, '') unless fulltext.blank? # remove all characters except german letters

    joins("LEFT JOIN action_text_rich_texts ON action_text_rich_texts.record_id = tasks.id  AND record_type = 'Task'")
      .where(
        "tasks.name ilike '%#{fulltext}%' OR
        subjects.name ilike '%#{fulltext}%' OR
        action_text_rich_texts.body ilike '%#{fulltext}%' OR
        teams.name ilike '%#{fulltext}%'"
      )
  }
  scope :filter_by_duedate_min, lambda { |duedate|
    duedate = Date.today - 14 if duedate.blank?
    where('"tasks"."duedate" > ?', duedate.to_s)
  }
  scope :filter_by_duedate_max, ->(duedate) { where('"tasks"."duedate" < ?', duedate.to_s) unless duedate.nil? }

  def worktype_name
    worktype ? 'Together in a group' : 'On your own'
  end

  def groupwork?
    worktype == true
  end

  def formatted_duedate
    duedate.strftime('%A, %d.%m.%y %H:%M')
  end
end
