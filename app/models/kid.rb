class Kid < ActiveRecord::Base
  belongs_to :users
  
  validates :name, :sex, :born_at, 
  :presence => {:message => 'Please enter a value for this field'}
  
end
