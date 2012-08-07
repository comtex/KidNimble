class SurveysController < ApplicationController
  # GET /surveys
  # GET /surveys.json
  layout "blank"

  def index
    @surveys = Survey.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @survey = Survey.find(params[:id])
    @survey.camp_id = :camp_id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @survey }
    end
  end

  def splash
    @surveys = Survey.all

    respond_to do |format|
      format.html #splash.html.erb
      format.json { render json: @surveys }
    end
  end

  def music_together_of_charlotte
    @surveys = Survey.all
    
    respond_to do |format|
      format.html 
      format.json { render json: @surveys }
    end
  end

  def kidville
    @surveys = Survey.all
    
    respond_to do |format|
      format.html 
      format.json { render json: @surveys }
    end
  end

  def city_treehouse
    @surveys = Survey.all
    
    respond_to do |format|
      format.html 
      format.json { render json: @surveys }
    end
  end

  def boys_and_girls_club_of_america
    @surveys = Survey.all
    
    respond_to do |format|
      format.html 
      format.json { render json: @surveys }
    end
  end

  def boy_scouts_of_america
    @surveys = Survey.all
    
    respond_to do |format|
      format.html 
      format.json { render json: @surveys }
    end
  end

  def girl_scouts
    @surveys = Survey.all
    
    respond_to do |format|
      format.html 
      format.json { render json: @surveys }
    end
  end


  def ymcanyc
    @surveys = Survey.all
    
    respond_to do |format|
      format.html 
      format.json { render json: @surveys }
    end
  end


  def jccmanhattan
    @surveys = Survey.all
    
    respond_to do |format|
      format.html 
      format.json { render json: @surveys }
    end
  end



  # GET /surveys/new
  # GET /surveys/new.json
  def new
    camp_id = params[:camp_id]
    @survey = Survey.new
    @survey.camp_id = camp_id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey }
    end
  end

  # GET /surveys/1/edit
  # def edit
  #   @survey = Survey.find(params[:id])
  # end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(params[:survey])
    camp_id = params[:camp_id]
    @survey.camp_id = camp_id

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render json: @survey, status: :created, location: @survey }
      else
        format.html { render action: "new" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.json

  def update
    @survey = Survey.find(params[:id])

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end





  # DELETE /surveys/1
  # DELETE /surveys/1.json
  # def destroy
  #   @survey = Survey.find(params[:id])
  #   @survey.destroy

  #   respond_to do |format|
  #     format.html { redirect_to surveys_url }
  #     format.json { head :no_content }
  #   end
  # end
end
