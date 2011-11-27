class Dataset < ActiveRecord::Base
	has_many :Chalenges #part of 
	has_many :Competitions #uses
	belongs_to :User #owned by admin
end
