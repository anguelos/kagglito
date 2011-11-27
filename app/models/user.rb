class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  #anguelos start
  has_many :Datasets #owned by admin
  has_many :Evaluators #writen by admin
  has_many :Competitions #hosted by admin
  has_many :Participations #declared by
  has_many :Submissions, :through => :Participations #declared by => part of
  #anguelos end
end
