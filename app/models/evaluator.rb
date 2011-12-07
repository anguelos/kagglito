class Evaluator < ActiveRecord::Base
  belongs_to :User #writen by admin
  has_many   :Competitions #evaluates with
  validates_uniqueness_of :name
  validates_presence_of :name
end
