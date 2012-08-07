class PostsController < InheritedResources::Base
  # GET /posts
  # GET /posts.json
  def index
    #not_found() unless current_user
    @users = get_related_users current_user, params[:group_id]
    if !params[:group_id].blank?
      @posts = Post.select("posts.title, posts.content, groups.name").where(:user_id => @users, :group_id => params[:group_id]).joins(:group).order("posts.created_at DESC")
    else
      @posts = Post.select("posts.title, posts.content, groups.name").where(:group_id => @users).joins(:group).order("posts.created_at DESC")
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post[:group_id] = params[:group_id]
    @group_id = params[:group_id];
    @post[:title] = "#{current_user.first_name} #{current_user.last_name[0,1]}"
    
    respond_to do |format|
      format.html {render :layout => false} # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    #not_found() unless current_user
    @current_user = current_user;
    @post = Post.new(params[:post])
    @post.user_id = @current_user.id
    @group_id = params[:post][:group_id];
    
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'

        @users = get_related_users current_user, @group_id
        # Tell the PostMailer to send a Email after save
        @users.each do |user|
          PostMailer.send_email(@group_id, @current_user, user, params[:post][:content]).deliver
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    #not_found() unless current_user
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      not_found()
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
  
  
  def get_related_users(cur_user, group_id)
    if !group_id.blank?
      @users = [cur_user]
      # Get the owner of the current group
      @group = Group.select(:user_id).where(:id => group_id).first
      
      if !@group.blank? && @group.user_id != cur_user.id
        @users << User.find(@group.user_id)
      end
      
      # Get the member related to current group
      @members = Member.select(:email).where(:group_id => group_id, :status => 1).uniq
      if !@members.blank?
        @members.each do |member|
          if member.email != cur_user.email
            @users << User.find_by_email(member.email)
          end
        end
      end
    else
      @users = []
      # Get the groups owned by current user
      @groups = Group.select(:id).where(:user_id => cur_user.id)
      if !@groups.blank?
        @groups.each do |group|
          @users << group.id
        end
      end
      # Get the groups who belongs to current user
      @members = Member.select(:group_id).where(:email => cur_user.email).uniq
      if !@members.blank?
        @members.each do |member|
          @users << member.group_id
        end
      end
    end

    return @users
  end
  
  
end

