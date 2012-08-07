class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    #not_found() unless current_user
    @groups = Group.where(:user_id => current_user.id)

    respond_to do |format|
      format.html
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @currentuser = current_user
    @kids = Kid.where(:user_id => @currentuser.id).order(:born_at)
    
    @group = Group.select("groups.id, user_id, name, first_name, last_name").where(:id => params[:id]).joins(:user).first
    
    @members = []
    # Get the owner of the current group
    if !@group.blank? && @group.user_id != @currentuser.id
      @members << User.find(@group.user_id)
    end
    
    # Get the member related to current group
    @memberids = Member.select(:email).where(:group_id => params[:id], :status => 1).uniq
    if !@memberids.blank?
      @memberids.each do |member|
        if member.email != @currentuser.email
          @members << User.find_by_email(member.email)
        end
      end
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html {render :layout => false} # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    #not_found() unless current_user
    @group = Group.new(params[:group])
    @group.user_id = current_user.id

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    #not_found() unless current_user
    @group = Group.find(params[:id])
    if @group.user_id != current_user.id
      not_found()
    end

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
