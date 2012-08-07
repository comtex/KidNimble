class Camp < ActiveRecord::Base
  acts_as_gmappable :latitude => 'lat', :lngongitude => 'lng', :process_geocoding => :geocode?,
                  :address => "address", :normalized_address => "address",
                  :msg => "Sorry, not even Google could figure out where that is"
  
  #has_many :events
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  has_many :bookmarks
  belongs_to :category
  belongs_to :subs
  has_many :assets
  accepts_nested_attributes_for :assets, :allow_destroy => true
  
  #has_many :deals
  
  def self.get_catname
    category = Category.select("categories.name AS category_name")
    joins(:category).merge(category)  
  end
  
  def self.events_between(dateStart, dateEnd)
    events = Event.where(:events => {:starttime => dateStart.to_date.beginning_of_day..dateEnd.to_date.end_of_day})
    joins(:events).merge(events)
  end

  def self.get_by_params(params)
    cityzipadd= params[:cityzipadd]
    zip       = params[:zip]
    distance  = params[:distance] || 20
    title     = params[:name]
    category  = params[:category]
    subs      = params[:subs]
    dateStart = params[:start]
    dateEnd   = params[:end]
    latitude  = params[:latitude] || 0.0
    longitude = params[:longitude] || 0.0
    page      = params[:page]
    pagesize  = params[:pagesize] || 10
    
    if zip and zip != '' and zip != 'Zip Code'
      loc = Zip.where(:zip => zip).first
      return [] unless loc
      latitude  = loc.latitude
      longitude = loc.longitude
    end

    if cityzipadd and cityzipadd != '' and cityzipadd != 'city, zip code or address'
      cityzipaddarr = cityzipadd.split(",")
      
      if !cityzipaddarr[1].blank?
        loc = Zip.where('city LIKE ? AND zip = ? OR state LIKE ?', "%#{cityzipaddarr[0].strip}%", cityzipaddarr[1].strip, "%#{cityzipaddarr[1].strip}%").first
      else
        if !cityzipaddarr[0].blank?
          loc = Zip.where('city LIKE ? OR zip = ?', "%#{cityzipaddarr[0].strip}%", cityzipaddarr[0].strip).first
        end
      end
      return [] unless loc
      latitude  = loc.latitude
      longitude = loc.longitude
    end
    
    if title and title != '' and title != 'Name'
      res = Camp.where('camps.title LIKE ?', "%#{title}%")
    end
    
    
    if category and category != 'Select...' and category != ''
      category_name = Category.find(category).name
      res = Camp.where('camps.category_id = ? OR camps.title LIKE ? OR camps.description LIKE ?', category, "%#{category_name}%", "%#{category_name}%")
      #res = Camp.where('category_id = ?', category)
    end
   
    if subs and subs != 'Select...' and subs != ''
      if res
        res = Camp.where('(camps.category_id = ? AND camps.subs_id = ?) OR camps.title LIKE ? OR camps.description LIKE ?', category, subs, "%#{category_name}%", "%#{category_name}%")
        #res = Camp.where('category_id = ? OR subs_id = ?', category, subs)
      else
        res = Camp.where(:subs_id => subs)
      end
    end
    
    if dateStart and dateStart =~ /^\d\d\d\d-\d\d-\d\d$/ and
       dateEnd   and dateEnd =~ /^\d\d\d\d-\d\d-\d\d$/
      res = Camp.events_between(dateStart,dateEnd)
    end
    
    if(latitude && longitude)
      if res
        res = res.near([latitude,longitude], distance)
      else
        res = Camp.near([latitude,longitude], distance)
      end 
    end
    
    return res.get_catname.page(page).per(pagesize)
  end
  
  
  def geocode?
    !(address.blank? || (!latitude.blank? && !longitude.blank?)) || address_changed?
  end
  
  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.latitude}, #{self.longitude}" 
  end
  
  def gmaps4rails_title
      "#{self.title}"
    end
    
  def gmaps4rails_infowindow
    "#{self.title}"
  end
end
