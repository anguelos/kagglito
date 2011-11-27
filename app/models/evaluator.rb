class Evaluator < ActiveRecord::Base
  belongs_to :User #writen by admin
  has_many   :Competitions #evaluates with

end
