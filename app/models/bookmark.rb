class Bookmark < ActiveRecord::Base
  belongs_to :users
  belongs_to :camp
  
end
