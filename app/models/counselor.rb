class Counselor < ActiveRecord::Base
  belongs_to :user
  validates :user_id,
    :presence => true,
    :uniqueness => true
  validates :camp_id,
    :presence => true,
    :format => /^\d+$/
end
