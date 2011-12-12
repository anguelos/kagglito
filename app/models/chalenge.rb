class Chalenge < ActiveRecord::Base
  belongs_to :Dataset #part of
  has_many :Submissions #responds to
  validates_uniqueness_of :name
  validates_presence_of :name
  def ownerId
	return @Dataset_id
  end
end
