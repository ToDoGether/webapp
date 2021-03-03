# frozen_string_literal: true

class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

  default_scope { order(is_admin: :desc) }

  def email
    user.email
  end
end
