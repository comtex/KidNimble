class Category < ActiveRecord::Base
  attr_accessible :id, :name
  
  has_many :camps
  has_many :subs
  has_many :mastercamp_details
  
end
