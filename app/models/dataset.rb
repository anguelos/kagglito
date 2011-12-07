class Dataset < ActiveRecord::Base
	has_many :Chalenges #part of 
	has_many :Competitions #uses
	belongs_to :User #owned by admin
	validates_uniqueness_of :name
	validates_presence_of :name
end
