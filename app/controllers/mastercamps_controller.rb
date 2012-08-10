class MastercampsController < ApplicationController

  # GET /camps
  # GET /camps.json
  def index
    @camps = MastercampDetail.get_by_params(params)

    respond_to do |format|
      format.html {  }# index.haml
      format.json { render json: @camps }
    end
  end
  
  # GET /camps/isbookmarked?
  def isbookmarked
    if current_user
      @bookmarked = true;
      @bookmark = Bookmark.where(:camp_id => params[:camp_id], :user_id => current_user.id).first
      if @bookmark.blank?
        @bookmarked = false;
      end
    end
    respond_to do |format|
      format.html { render 'togglebookmark', :layout => false}
    end
  end
  
  # GET /camps/togglebookmark
  def togglebookmark
    if current_user
      @bookmarked = true;
      @bookmark = Bookmark.where(:camp_id => params[:camp_id], :user_id => current_user.id).first
      if !@bookmark.blank?
        @bookmark.destroy
        @bookmarked = false;
      else
        @bookmark = Bookmark.new
        @bookmark.camp_id = params[:camp_id]
        @bookmark.user_id = current_user.id
        @bookmarked = true;
        @bookmark.save
      end
    end
    respond_to do |format|
      format.html { render :layout => false}
    end
  end
  
  # GET /camps/getcategoryname
  def getcategoryname
    @category = Category.where(:id => params[:category_id]).first

    respond_to do |format|
      format.html { render :layout => false}
    end
  end
  
  
  def kaminari
    @camps = Camp.get_by_params(params)
    respond_to do |format|
      format.html { render :partial => 'kaminari' }
      format.json { render :partial => 'kaminari' }
    end
  end

  # GET /camps/1
  # GET /camps/1.json
  def show
    @camp = MastercampDetail.select("mastercamp_details.*, contact, phone, fax, email, website").where(:id => params[:id]).joins(:mastercamp)
          .joins("LEFT JOIN categories ON categories.id = mastercamp_details.category_id").merge(Category.select("categories.name AS category_name"))
          .first
          
    #@camp = @camps[:0]
    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @camp }
    end
  end

  # GET /camps/new
  # GET /camps/new.json
  def new
    @camp = Camp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @camp }
    end
  end

  # GET /camps/1/edit
  def edit
    @camp = Camp.find(params[:id])
  end

  # POST /camps
  # POST /camps.json
  def create
    @camp = Camp.new(params[:camp])

    respond_to do |format|
      if @camp.save
        format.html { redirect_to @camp, notice: 'Camp was successfully created.' }
        format.json { render json: @camp, status: :created, location: @camp }
      else
        format.html { render action: "new" }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /camps/1
  # PUT /camps/1.json
  def update
    @camp = Camp.find(params[:id])

    respond_to do |format|
      if @camp.update_attributes(params[:camp])
        format.html { redirect_to @camp, notice: 'Camp was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camps/1
  # DELETE /camps/1.json
  def destroy
    @camp = Camp.find(params[:id])
    @camp.destroy

    respond_to do |format|
      format.html { redirect_to camps_url }
      format.json { head :ok }
    end
  end
end
