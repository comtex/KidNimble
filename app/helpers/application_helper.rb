module ApplicationHelper
  def display_distance
    options_for_select([['1 Mile', 1], ['20 Miles', 20], ['50 Miles', 50], ['100 Miles', 100], ['250 Miles', 250]], params[:distance] || 20)
  end
  
  def display_pagesizes
    options_for_select([['10', 10], ['25', 25], ['50', 50], ['100', 100]], 10)
  end
  
  def display_categories
    opt = []
    Category.where("id > 0").order(:name).each do |cat|
      opt.push [cat.name, cat.id]
    end
    
    #Category.order(:id).each do |cat|
    #  Subs.where(:category_id => cat.id).order(:name).each do |sub|
    #    opt.push [sub.name, sub.id]
    #  end
    #end
    options_for_select(opt, params[:category])
  end
  
  def display_activities
    opt = []
    Subs.where(:category_id => 0).order(:name).each do |sub|
      opt.push [cat.sub, cat.sub]
    end
    
    #opt.push(['Activity 1', '1'])
    #opt.push(['Activity 2','2'])
    #opt.push(['Activity 3','3'])
    
    options_for_select(opt, params[:subs])
  end

  def truncate(text, options = {})
    options.reverse_merge!(:length => 30)
    text.truncate(options.delete(:length), options) if text
  end  
  
  def current_url(overwrite={})
    url_for :only_path => false, :params => params.merge(overwrite)
  end
  

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end
