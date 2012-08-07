class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index

  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.js
  def new
    @event = Event.new(:endtime => 1.hour.from_now, :period => "Does not repeat")
    @event[:group_id] = params[:group_id]
    @group_id = params[:group_id];
    respond_to do |format|
      format.html  { render :layout => false }
      format.js  { render :layout => false }
    end
  end
  
  # POST /events
  # POST /events.js
  def create
    @group_id = params[:event][:group_id];
    params[:event][:user_id] = current_user.id
    if params[:event][:period] == "Does not repeat"
      @event = Event.new(params[:event])
      if !@event.save
        @errors = @event.errors
      end
    else
      #      @event_series = EventSeries.new(:frequency => params[:event][:frequency], :period => params[:event][:repeats], :starttime => params[:event][:starttime], :endtime => params[:event][:endtime], :all_day => params[:event][:all_day])
      @event_series = EventSeries.new(params[:event])
      if !@event_series.save
        @errors = @event_series.errors
      else
        #@event.event_series_id = @event_series.id
        #if !@event.save
        #  @errors = @event.errors
        #end
      end
    end
    respond_to do |format|
      format.js  { render :layout => false }
    end
  end
  
  
  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html  { render :layout => false }
      format.js  { render :layout => false }
    end
  end
  
  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    @event.user_id = current_user.id
    @group_id = params[:event][:group_id];
    if params[:event][:commit_button] == "Update All Occurrence"
      @events = @event.event_series.events #.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.update_events(@events, params[:event])
    elsif params[:event][:commit_button] == "Update All Following Occurrence"
      @events = @event.event_series.events.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.update_events(@events, params[:event])
    else
      @event.attributes = params[:event]
      @event.save
    end
    if !@event.errors.blank?
      @errors = @event.errors
    end
    respond_to do |format|
      format.js  { render :layout => false }
    end
  end  
  
  def destroy
    @event = Event.find_by_id(params[:id])
    if params[:delete_all] == 'true'
      @event.event_series.destroy
    elsif params[:delete_all] == 'future'
      @events = @event.event_series.events.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.event_series.events.delete(@events)
    else
      @event.destroy
    end
    
    respond_to do |format|
      format.js  { render :layout => false }
    end  
  end
  
  def get_events
    @currentuser = current_user
    
    @users = [@currentuser]
    # Get the owner of the current group
    @group = Group.select(:user_id).where(:id => params[:group_id]).first
    
    if !@group.blank? && @group.user_id != @currentuser.id
      @users << User.find(@group.user_id)
    end
    
    # Get the member related to current group
    @memberids = Member.select(:email).where(:group_id => params[:group_id], :status => 1).uniq
    if !@memberids.blank?
      @memberids.each do |member|
        if member.email != @currentuser.email
          @users << User.find_by_email(member.email)
        end
      end
    end
    
    if !params[:group_id].blank?
      @events = Event.where("starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'").where(:group_id => params[:group_id], :user_id => @users)
    else
      @events = Event.where("starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'").where(:user_id => @users)
    end
    events = [] 
    @events.each do |event|
      events << {:id => event.id, :title => event.title, :description => event.description || "Some cool description here...", :start => "#{event.starttime.iso8601}", :end => "#{event.endtime.iso8601}", :allDay => event.all_day, :recurring => (event.event_series_id)? true: false, :group_id => event.group_id}
    end
    render :text => events.to_json
  end
  
  def move
    @event = Event.find_by_id params[:id]
    if @event
      @event.starttime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.starttime))
      @event.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
      @event.all_day = params[:all_day]
      @event.save
    end
    respond_to do |format|
      format.html { render :layout => false }
      format.js  { render :layout => false }
    end
  end
  
  
  def resize
    @event = Event.find_by_id params[:id]
    if @event
      @event.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
      @event.save
    end
    respond_to do |format|
      format.html { render :layout => false }
      format.js  { render :layout => false }
    end
  end

  def correct_date(date)
    date.gsub(%r!(\d+)/(\d+)/(\d+)\s*(\d+):(\d+)!, '\3-\1-\2 \4:\5:00')
  end
  
end
