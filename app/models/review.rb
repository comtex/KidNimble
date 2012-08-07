class Review < ActiveRecord::Base
  attr_accessor :commit_button
  
  belongs_to :user
  validates :rating, :numericality => { :greater_than => 0, :less_than_or_equal_to => 5 }, :presence => true

  validates :rating, :note,
  :presence => {:message => 'is required field'}
  
  before_save :default_values
  def default_values
    self.rating = 1 unless self.rating
    self.note = " " unless self.note
    self.approved = 'Y' unless self.approved
  end
end
