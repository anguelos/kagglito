class Competition < ActiveRecord::Base
	has_many :Participations #participates to
  has_many :Submissions, :through => :Participations
	belongs_to:Evaluator #evaluates with
	belongs_to:User #hosted by admin
	belongs_to:Dataset #uses
    validates_uniqueness_of :name
	validates_presence_of :name
end
