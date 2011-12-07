class Submission < ActiveRecord::Base
  belongs_to :Chalenge
  belongs_to :participation
  belongs_to :User
end
