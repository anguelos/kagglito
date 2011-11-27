class Chalenge < ActiveRecord::Base
  belongs_to :Dataset #part of
  has_many :Submissions #responds to
end
