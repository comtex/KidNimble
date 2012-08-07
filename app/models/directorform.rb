class Directorform < ActiveRecord::Base
	validates_presence_of :session_title, :subcategory, :residency, :date_start, :date_end, :youngest, :oldest, :location_address, :session_description
    #validates :rating, :numericality => { :greater_than => 0,  :less_than => 6}
    #validates :like, :improve, :length => { :minimum => 25 }
	#validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
end
