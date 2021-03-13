# frozen_string_literal: true

class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_rich_text :personal_note

  scope :filter_by_status, lambda { |status|
    status = '1, 2' if status.blank?
    status = '1, 2, 3' if status == '4'
    where("status IN ( #{status} )")
  }

  def status_prev
    status - 1
  end

  def status_next
    status + 1
  end

  def status_name(status_nr = status)
    case status_nr
    when 1
      'todo'
    when 2
      'doing'
    when 3
      'done'
    else
      'nostatus'
    end
  end

  def self.concrete_user_task(uid, tid)
    UserTask.all.where(user_id: uid).where(task_id: tid).first
  end
end
