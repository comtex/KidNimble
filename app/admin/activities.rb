ActiveAdmin.register Activity do
  menu false
  member_action :build, :method => :get do
    @activity = Activity.new
    @activity.camp_id = params[:id]
    @activity.save
    @activitys = Activity.where("camp_id = ? AND kind != '' AND kind is not null", @activity.camp_id)
  end
end
