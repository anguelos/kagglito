class Competition < ActiveRecord::Base
	has_many :Participations #participates to
	belongs_to:Evaluator #evaluates with
	belongs_to:User #hosted by admin
	belongs_to:Dataset #uses
    validates_uniqueness_of :name
	validates_presence_of :name
end
