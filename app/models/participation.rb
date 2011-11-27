class Participation < ActiveRecord::Base
  belongs_to :User #declared by
  belongs_to :Competition #participates to
  has_many :Submissions #part of
end
