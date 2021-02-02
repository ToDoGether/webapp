class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user

  def status_prev
    status - 1
  end

  def status_next
    status + 1
  end

  def status_name(status_nr)
    case status_nr
    when 1
      "todo"
    when 2
      "doing"
    when 3
      "done"
    else
      "nostatus"
    end
  end
end
