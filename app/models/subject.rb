class Subject < ApplicationRecord
  belongs_to :team
  has_many :tasks

  delegate :name, to: :team, prefix: true
end
