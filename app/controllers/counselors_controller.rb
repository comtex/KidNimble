class CounselorsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  
  # GET /counselors
  # GET /counselors.json
  def index
    @counselors = Counselor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @counselors }
    end
  end

  # GET /counselors/1
  # GET /counselors/1.json
  def show
    @counselor = Counselor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @counselor }
    end
  end

  # get associated couselor through camp_id
  def for_camp
    puts "COUNSELOR FOR CAMP - #{params.inspect}"
    @counselor = Counselor.find_by_camp_id(params[:camp_id])
    respond_to do |format|
      format.json { render json: @counselor }
    end
  end


  # GET /counselors/new
  # GET /counselors/new.json
  def new
    @counselor = Counselor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @counselor }
    end
  end

  # GET /counselors/1/edit
  def edit
    @counselor = Counselor.find(params[:id])
  end

  # POST /counselors
  # POST /counselors.json
  def create
    @counselor = Counselor.new
    @counselor.user_id = current_user.id
    @counselor.camp_id = params[:camp_id]

    respond_to do |format|
      if @counselor.save
        format.json { render json: @counselor }
      else
        format.json { render json: @counselor.errors }
      end
    end
  end

  # PUT /counselors/1
  # PUT /counselors/1.json
  def update
    @counselor = Counselor.find(params[:id])

    respond_to do |format|
      if @counselor.update_attributes(params[:counselor])
        format.html { redirect_to @counselor, notice: 'Counselor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @counselor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counselors/1
  # DELETE /counselors/1.json
  def destroy
    @counselor = Counselor.find(params[:id])
    @counselor.destroy

    respond_to do |format|
      format.html { redirect_to counselors_url }
      format.json { head :no_content }
    end
  end
end
