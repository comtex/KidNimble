class Member < ActiveRecord::Base
  
  belongs_to :group
  
  validates :email, :uniqueness => {:scope => [:group_id, :user_id], :message => 'has already invited by you for this group'}
  
  validates :first_name, :last_name, :email,
  :presence => {:message => 'is required field'}
  
end
