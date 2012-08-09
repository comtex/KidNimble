class Subs < ActiveRecord::Base
  attr_accessible :id, :name
  
  has_one :camps
  belongs_to :category
  has_many :mastercamp_details
  
end
