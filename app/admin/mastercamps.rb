ActiveAdmin.register Mastercamp do
  menu :label => "Master Camps"
  
  filter :contact
  filter :phone
  filter :fax
  filter :email
  filter :website
    
  form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :contact, :label => "Contact"
      f.input :phone,   :label => "Phone"
      f.input :fax,     :label => "Fax"
      f.input :email,   :label => "E-Mail"
      f.input :website, :label => "Website"
      #f.inputs "Camp Details" do
      f.has_many :mastercamp_details, {:label => "Camp Details"} do |d|
        d.input :camp_name, :label => "Camp Name"
        d.input :description, :label => "Description"
        d.input :residency, :label => "Residency"
        d.input :city, :label => "City"
        d.input :state, :label => "State"
        d.input :zip, :label => "Zip Code"
        d.input :latitude, :label => "Latitude"
        d.input :longitude, :label => "Longitude"
        d.input :category, :input_html => {
          :onchange => remote_request(:post, '/admin/mastercamps/change_subs', {:id=>"$(this).val()"}, "#{d.object.id.nil? ? 'NEW_RECORD' : d.object.id}_subs_id")
        }
        d.input :subs, :input_html => {:id => "#{d.object.id.nil? ? 'NEW_RECORD' : d.object.id}_subs_id"}
        d.input :youngest, :label => "Youngest"
        d.input :oldest, :label => "Oldest"
        d.input :datetime_start, :label => "Start Datetime"
        d.input :datetime_end, :label => "End Datetime"
        
        #d.inputs "Assets" do
        d.has_many :assets do |a|
          a.input :asset, :as => :file, :label => "Asset",:hint => a.object.asset.nil? ? a.template.content_tag(:span, "No Asset Yet") : a.template.image_tag(a.object.asset.url(:thumb))
          if !a.object.nil?
            a.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove Asset'
          end
        end
        #end
        if !d.object.nil?
          d.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove Camp'
        end
      end
      #end
    end
    f.buttons
  end
  
  def remote_request(type, path, params={}, target_tag_id)
    "$.#{type}('#{path}',
               {#{params.collect { |p| "#{p[0]}: #{p[1]}" }.join(", ")}},
               function(data) {$('##{target_tag_id}').html(data);}
     );"
  end
  
  controller do
    def change_subs
      @subs = Subs.where(:category_id => params[:id])
      if @subs.blank?
        #@subs = {'name' => ""},{'id' => 0}
      end
      Rails.logger.debug "Sub Category: #{@subs.inspect}"
      render :text=>view_context.options_from_collection_for_select(@subs, :id, :name)
    end
  end

  index do
    column :contact
    column :phone
    column :fax
    column :email
    column :website
    default_actions
  end
  
  show do
    panel("Camp") do
      attributes_table_for mastercamp do
        [:contact, :phone, :fax, :email, :website].each do |column|
          row column
        end
      end
    end
    panel "Camp Details" do
      table_for mastercamp.mastercamp_details do |details|
        column :camp_name
        column :description
        column :residency
        column :city
        column :state
        column :zip
        column :latitude
        column :longitude
        column :category
        column :subs
        column :youngest
        column :oldest
        column :datetime_start
        column :datetime_end
        column "Assets" do |details|
          link_to "Assets", "/admin/assets/#{details.id}/build"
        end
      end
    end
    active_admin_comments
  end
  
end