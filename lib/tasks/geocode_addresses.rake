require 'geocoder'

namespace :camp do
  task :geocode_addresses => :environment do
    db = Geocoder::US::Database.new(Rails.root.join("..", "geocoder", 'geocoder.sqlite3').to_s)
    Camp.all.each do |camp|
      next if camp.address.nil? or camp.address.gsub(/^\s*$/, '').blank?
      if camp.address =~ /(?:\d\d\d\d\d(?:-\d\d\d\d)?)\s*$/
        address = camp.address
      else
        address = "#{camp.address} #{camp.city} #{camp.state} #{camp.zip}"
      end
      STDERR.puts "Looking up: '#{address}'"
      res = db.geocode( address )
      if res and res.length > 0
        camp.latitude = res[0][:lat]
        camp.longitude= res[0][:lon]
        camp.city = res[0][:city]
        camp.state = res[0][:state]
        camp.zip = res[0][:zip]
        camp.save
      end
    end
  end
end
