class Submission < ActiveRecord::Base
  belongs_to :Chalenge
  belongs_to :participation
end
