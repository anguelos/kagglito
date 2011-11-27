class Participation < ActiveRecord::Base
  belongs_to :User
  belongs_to :Competition
end
