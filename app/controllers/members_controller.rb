class MembersController < InheritedResources::Base
  # GET /members
  # GET /members.json
  def index
    #not_found() unless current_user
    
    if !params[:group_id].blank?
      @members = Member.select("members.first_name, members.last_name, groups.name").where(:user_id => current_user.id, :group_id => params[:group_id]).joins(:group)
    else
      @members = Member.select("members.first_name, members.last_name, groups.name").where(:user_id => current_user.id).joins(:group)
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new
    @member[:group_id] = params[:group_id]
    @member[:status] = 0
    @group_id = params[:group_id];
    
    respond_to do |format|
      format.html {render :layout => false} # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    #not_found() unless current_user
    @member = Member.new(params[:member])
    @member.user_id = current_user.id
    @group_id = params[:member][:group_id];
    respond_to do |format|
      if @member.save
        @member_user = User.find_by_email(params[:member][:email])
        if @member_user.blank?
          @member_user = User.new
          @member_user.first_name = params[:member][:first_name]
          @member_user.last_name = params[:member][:last_name]
          @member_user.email = params[:member][:email]
          @member_user.password = "campgurus"
          @member_user.password_confirmation = "campgurus"
          
          if @member_user.save
            # Tell the MemberInvite to send a Email after save
            MemberInvite.send_email_non_member(@member, current_user, @group_id).deliver
          else
            logger.info "Error: "+@member_user.errors.to_yaml
          end
        else
          # Tell the MemberInvite to send a Email after save
          MemberInvite.send_email_member(@member, current_user, @group_id).deliver
        end
        
        flash[:notice] = 'Member was successfully invited.'
        format.html { redirect_to @member, notice: 'Member was successfully invited.' }
        format.json { render json: @member, status: :created, location: @member }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end
  

  def acceptinvitation
    @hash = params[:hash].split("-")    
    @member = Member.find(@hash[1])
    if !@member.blank?
      data = {}
      data[:status] = 1
      @member.update_attributes(data)
      
      # Tell the MemberInvite to send a Email after save
      MemberInvite.send_email_confirmation(@member, @member.group_id).deliver
      
      sign_out :user
      @user = User.find_by_email(@member.email)
      if @user.sign_in_count > 0
        sign_in @user
        redirect_to after_sign_in_path_for(@user)
      else
        userdata = {}
        @user.confirmation_token = ''
        @user.confirmed_at = @user.confirmation_sent_at
        @user.save
        sign_in @user
        redirect_to after_first_sign_in_path_for(@user)
      end
    end
    
  end


  # PUT /members/1
  # PUT /members/1.json
  def update
    #not_found() unless current_user
    @member = Member.find(params[:id])
    if @member.user_id != current_user.id
      not_found()
    end

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
end


