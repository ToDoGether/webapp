# frozen_string_literal: true

class Subject < ApplicationRecord
  belongs_to :team
  has_many :tasks

  delegate :name, to: :team, prefix: true

  default_scope { order('name') }
end
