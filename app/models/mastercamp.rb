class Mastercamp < ActiveRecord::Base
  
  has_many :mastercamp_details
  accepts_nested_attributes_for :mastercamp_details, :reject_if => lambda { |a| a[:camp_name].blank? }, :allow_destroy => true
  
  /
  validate_on_create :mastercamp_details_count_within_bounds
  
  #validates :contact, :phone, :presence => {:message => 'is required field'}
  
  private

  def mastercamp_details_count_within_bounds
    return if mastercamp_details.blank?
    errors.add("Too many Camps") if mastercamp_details.length > 6
  end
  /
  
end
