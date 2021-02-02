class Subject < ApplicationRecord
  belongs_to :team
  has_many :tasks

  def color
    "#660000" # TODO: implement, add to database
  end
end
