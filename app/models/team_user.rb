class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

#   attr_accessor :team_id, :user_id, :is_admin

#   def initialize(team_id, user_id, is_admin)
#     @team_id = team_id
#     @user_id = user_id
#     @is_admin = is_admin
#   end
end
