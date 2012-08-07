ActiveAdmin.register Asset do
  menu false
  member_action :build, :method => :get do
    @asset = Asset.new
    @asset.camp_id = params[:id]
    #@asset.save
    @assets = Asset.where("camp_id = ?", @asset.camp_id)
  end
  
end
