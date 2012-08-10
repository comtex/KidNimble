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
      f.input :phone, :as => :phone,  :label => "Phone", :input_html => {:class => 'phone'}
      f.input :fax, :as => :phone,     :label => "Fax", :input_html => {:class => 'fax'}
      f.input :email, :as => :email,   :label => "E-Mail", :input_html => {:class => 'email'}
      f.input :website, :as => :url, :label => "Website", :placeholder => "http://www.example.com", :input_html => {:class => 'optional defaultInvalid url'}
      #f.inputs "Camp Details" do
      f.has_many :mastercamp_details, :class => "CampDetails" do |d|
        d.input :camp_name, :label => "Camp Name", :input_html => {:class => 'required'}
        d.input :description, :label => "Description", :input_html => {:class => 'required'}
        d.input :street, :label => "Street", :input_html => {:class => 'required'}
        d.input :city, :label => "City", :input_html => {:class => 'required'}
        d.input :state, :label => "State", :input_html => {:class => 'required'}
        d.input :zip, :as => :number, :label => "Zip Code", :input_html => {:class => 'required number'}
        d.input :latitude, :label => "Latitude", :input_html => {:class => 'required decimal'}
        d.input :longitude, :label => "Longitude", :input_html => {:class => 'required decimal'}
        d.input :category,  :label => "Category", :input_html => {
          :onchange => remote_request(:post, '/admin/mastercamps/change_subs', {:id=>"$(this).val()"}, "#{d.object.id.nil? ? 'NEW_RECORD' : d.object.id}_subs_id")
        }
        d.input :subs,  :label => "Sub Category", :input_html => {:id => "#{d.object.id.nil? ? 'NEW_RECORD' : d.object.id}_subs_id"}
        d.input :youngest, :label => "Youngest"
        d.input :oldest, :label => "Oldest"
        d.input :datetime_start, :as => :string, :label => "Start Datetime", :input_html =>{:class => "hasDateTimePicker"}
        d.input :datetime_end, :as => :string, :label => "End Datetime", :input_html =>{:class => "hasDateTimePicker"}
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
    panel "Camp" do
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
        column :street
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
