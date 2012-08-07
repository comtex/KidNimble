class Group < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_many :memberss
  
  validates :name,
  :presence => {:message => 'is required field'}
  
end
