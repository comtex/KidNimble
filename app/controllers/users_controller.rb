class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:sign_in, :sign_up, :auth]
  
  def index
    @users = []
    # Get the groups owned by current user
    @groups = Group.select(:id).where(:user_id => current_user.id)
    if !@groups.blank?
      @groups.each do |group|
        @users << group.id
      end
    end
    # Get the groups who belongs to current user
    @members = Member.select(:group_id).where(:email => current_user.email).uniq
    if !@members.blank?
      @members.each do |member|
        @users << member.group_id
      end
    end
    
    @groups = Group.select("id, name").where(:id => @users).order(:name)
    @kids = Kid.where(:user_id => current_user.id).order(:born_at)
    @categories = Category.all(:order => "name ASC")
    @subcategory = Subs.where(:category_id => 0).order(:name)
    
    @bookmarked_camps = Camp.select("camps.id, camps.title, camps.description").joins(:bookmarks).where("bookmarks.user_id = ?", current_user.id).order("bookmarks.created_at DESC")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end
   
   
   def changepassword
     if params[:user].blank?
       @user = User.new
     else
       @user = User.find(current_user.id)

       if @user.valid_password?(params[:user][:current_password])
         @user.password = params[:user][:password]
         @user.password_confirmation = params[:user][:password_confirmation]
         if @user.save
           sign_in @user, :bypass => true
         end
       else
         @user.errors.add(:password, " doesn't match, Please enter valid password.")
       end
     end
     
     respond_to do |format|
      format.html { render :layout => false }# changepassword.html.haml
      format.js { render :layout => false }
    end
      
   end
   
   
end
