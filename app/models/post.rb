class Post < ActiveRecord::Base
  belongs_to :group
  
  
  validates :title, :content,
  :presence => {:message => 'is required field'}
  
end
