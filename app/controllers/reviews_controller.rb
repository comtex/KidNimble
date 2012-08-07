require 'csv' 

class ReviewsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :new, :create]
  
  
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.select([:source_url, :rating, :note, :first_name, :last_name]).where(:camp_id => params[:camp_id], :approved => 'Y').order('reviews.created_at DESC').joins(:user)
    
    respond_to do |format|
      format.html
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    unless current_user
      render html
      render json: {'status' => 'logged out'}
    else
      @review = Review.where(:user_id => current_user.id, :camp_id => params[:id]).first
      respond_to do |format|
        format.html
        format.json { render json: @review }
      end
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new
    @camp_id = params[:camp_id]
    @url = params[:url]

    respond_to do |format|
      format.html { render :layout => false }# new.html.erb
      format.json { render json: @review }
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.js
  def create
    unless current_user
      # Set a cookie that expires in 1 hour
      if !params[:review].blank?
        @tempreview = TempReview.new
        @camp_id = params[:review][:camp_id]
        @url = params[:review][:url]
        @tempreview.camp_id = @camp_id
        @tempreview.rating = params[:review][:rating]
        @tempreview.note = params[:review][:note]
        @tempreview.url = params[:review][:url]
        @commitbutton = params[:review][:commit_button]
        if !@tempreview.save
          @review = Review.new
          @review.errors.initialize_dup(@tempreview.errors)
        end
        respond_to do |format|
          format.js { render :layout => false }
        end
      end
    else
      @review = Review.new(params[:review])
      @review.user_id = current_user.id
      @camp_id = params[:review][:camp_id]
      @url = params[:review][:url]

      respond_to do |format|
        if @review.save
          # Tell the ReviewMailer to send a Email after save
          ReviewMailer.send_email(@review, current_user).deliver
            
          @camp = Camp.find(@camp_id)
          @camp.rating = 0 unless @camp.rating
          @camp.raters = 0 unless @camp.raters
          @camp.rating = @camp.rating + @review.rating
          @camp.raters += 1
          @camp.save
          
          format.html { redirect_to(@review, :notice => 'Review was successfully created.') }
          format.xml  { render :xml => @review, :status => :created, :location => @review }
          format.js { render :layout => false }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
          format.js { render :layout => false }
        end
      end
    end
  end
  
  def current_url(overwrite={})
    url_for :only_path => false, :params => params.merge(overwrite)
  end
  
  # POST /reviews/addreview
  # POST /reviews/addreview.json
  def addreview
    if current_user
      @review = Review.new
      @camp = Camp.find(params[:camp_id])
      @review.user_id = current_user.id
      @review.camp_id = @camp.id
      @review.rating  = params[:rating]
      @review.title   = params[:title]
      @review.note    = params[:note]
      @errors = nil
      if @review.save
        @camp.rating = 0 unless @camp.rating
        @camp.raters = 0 unless @camp.raters
        @camp.rating = @camp.rating + @review.rating
        @camp.raters += 1
        unless @camp.save
          @errors = @camp.errors
        end
      else
        @errors = @review.errors
      end
    
    else
      @errors = "Please Sign in to review."
    end
    
    respond_to do |format|
        unless @errors
          format.html { render :layout => false}
          format.js { render :layout => false}
        else
          format.html { render :layout => false}
          format.js { render :layout => false}
        end
    end
    
  end
  
   
  # GET /reviews/addreviewfromcsv
  # POST /reviews/addreviewfromcsv.json
  def addreviewfromcsv
    
    if params[:file]
      n = 0
      csv = CSV.parse(params[:file].tempfile, :headers => true)
      csv.each do |col|
        @camp = Camp.find_by_title(col[1])
        if !@camp
          @camp = Camp.new
          @camp.url = col[0]
          @camp.title = col[1]
          @camp.city = col[2]
          @camp.state = col[3]
          @camp.link = col[4]
          #@camp.address = col[2] << " " << col[3]
          @camp.phone = col[5]
          @camp.phone2 = col[6]
          @camp.category_id = col[11]
        end
        
        @review = Review.new
        @review.user_id = 3
        
        @review.source_url = col[0]
        @review.note = col[13]
        @review.title = col[1]
        @review.rating = col[7].sub!("Rating: ","").split(" out")[0].to_i
        
        @camp.rating = 0 unless @camp.rating
        @camp.raters = 0 unless @camp.raters
        @camp.rating = @camp.rating + @review.rating
        @camp.raters += 1
          
        if @camp.save
          @review.camp_id = @camp.id
          if @review.save
            n = n+1
            GC.start if n%50==0
          end
        end
        flash.now[:message] = "CSV Import Successful, #{n} new courses added to the database."
      end
    end
    respond_to do |format|
        format.html
        format.json { render :layout => false}
    end
  end
  
  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])
    @review.title  = params[:title]
    @review.note   = params[:note]
    @review.rating = params[:rating]
    respond_to do |format|
      if @review.save
        format.json { head :no_content }
      else
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end
end
