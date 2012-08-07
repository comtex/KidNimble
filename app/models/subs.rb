class Subs < ActiveRecord::Base
  attr_accessible :id, :name
  
  has_one :camps
end
