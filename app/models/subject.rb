class Subject < ApplicationRecord
  belongs_to :team
  has_many :tasks
end
