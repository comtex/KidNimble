ActiveAdmin.register Asset do
  menu false
  member_action :build, :method => :get do
    @asset = Asset.new
    @asset.mastercamp_detail_id = params[:id]
    #@asset.save
    @assets = Asset.where("mastercamp_detail_id = ?", @asset.mastercamp_detail_id)
  end
  
end
