ActiveAdmin.register MastercampDetail do
  menu :label => "MasterCamp Details"
  
  filter :camp_name
  filter :street
  filter :city
  filter :state
  filter :zip
  filter :description
  filter :latitude
  filter :longitude
  filter :category
  filter :subs
  filter :youngest
  filter :oldest
  filter :datetime_start
  filter :datetime_end
  filter :rating
  filter :raters
    
  form :html => { :multipart => true } do |d|
    d.inputs do
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
    end
    d.buttons
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

  index do |camp|
    column :camp_name
    column :street
    column :city
    column :state
    column :zip
    default_actions
  end
  
  show do |camp|
    panel "Camp" do
      attributes_table_for camp.mastercamp do
        row :contact
        row :phone
        row :fax
        row :email
        row :website
      end
    end
    panel "Camp Details" do
      attributes_table_for camp do
        row :camp_name
        row :description
        row :street 
        row :city 
        row :state 
        row :zip 
        row :latitude 
        row :longitude 
        row :category 
        row :subs 
        row :youngest 
        row :oldest 
        row :datetime_start 
        row :datetime_end
        row "Assets" do
          link_to "Assets", "/admin/assets/#{camp.id}/build"
        end
      end
    end
    active_admin_comments
  end
  
end
