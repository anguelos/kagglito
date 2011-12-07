class Participation < ActiveRecord::Base
  belongs_to :User #declared by
  belongs_to :Competition #participates to
  has_many :Submissions #part of
  validates_uniqueness_of :name
  validates_presence_of :name
end
