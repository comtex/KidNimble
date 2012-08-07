ActiveAdmin.register Event do
  menu false
  member_action :build, :method => :get do
    @event = Event.new
    @event.camp_id = params[:id]
    @event.save
    @events = Event.where("camp_id = ? AND name != '' AND name is not null", @event.camp_id)
  end
end
