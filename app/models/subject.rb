class Subject < ApplicationRecord
  belongs_to :team

  def color
    "#660000" # TODO: implement, add to database
  end
end
