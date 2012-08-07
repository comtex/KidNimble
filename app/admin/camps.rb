ActiveAdmin.register Camp do
  filter :title
  filter :city
  filter :state
  filter :zip
  filter :location
  filter :description
  filter :link
  filter :email
  filter :phone
  filter :phone2
  filter :address
  filter :longitude
  filter :latitude
  filter :director
  filter :rating
  filter :raters
  #filter :asset, :as => :select , :collection => proc { Asset.all }
  filter :category, :as => :select , :collection => proc { Category.where("id != 0") }
  filter :subs, :as => :select , :collection => proc { Subs.all }

  form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :title, :label => "Title"
      f.input :category, :select => proc { Category.all }
      f.input :subs, :select => proc { Subs.all }
      f.input :description, :label => "Description"
      f.input :link, :label => "Website"
      f.input :director, :label => "Contact Name"
      f.input :phone, :label => "Phone"
      f.input :address, :label => "Street Address"
      f.input :city, :label => "City"
      f.input :state, :label => "State"
      f.input :zip, :label => "Zip Code"
      f.inputs "Assets" do
        f.has_many :assets do |p|
          p.input :asset, :as => :file, :label => "Asset",:hint => p.object.asset.nil? ? p.template.content_tag(:span, "No Asset Yet") : p.template.image_tag(p.object.asset.url(:thumb))
          p.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove Asset'
        end
      end
      f.input :latitude, :label => "Latitude"
      f.input :longitude, :label => "Longitude"

    end
    f.buttons
  end

  index do
    column :title
    column :city
    column :state
    column :zip
    column :link do |camp|
      link_to "URL", camp.link
    end
    column :category
    column "Assets" do |camp|
      link_to "Assets", "/admin/assets/#{camp.id}/build"
    end
    #column "Events" do |camp|
    #  link_to "Events", "/admin/events/#{camp.id}/build"
    #end
    #column "Activities" do |camp|
    #  link_to "Activities", "/admin/activities/#{camp.id}/build"
    #end
    column "Edit" do |camp|
      link_to "Edit", "/admin/camps/#{camp.id}/edit"
    end
  end
end
