class DirectorformsController < ApplicationController
layout "blank"
  # GET /directorforms
  # GET /directorforms.json
  def index
    @directorforms = Directorform.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @directorforms }
    end
  end

  # GET /directorforms/1
  # GET /directorforms/1.json
  def show
    @directorform = Directorform.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @directorform }
    end
  end

  # GET /directorforms/new
  # GET /directorforms/new.json
  def new
    @directorform = Directorform.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @directorform }
    end
  end

  # GET /directorforms/1/edit
  def edit
    @directorform = Directorform.find(params[:id])
  end

  # POST /directorforms
  # POST /directorforms.json
  def create
    @directorform = Directorform.new(params[:directorform])

    respond_to do |format|
      if @directorform.save
        format.html { redirect_to @directorform, notice: 'Thank you - your form was sucessfully submitted! You will be redirected to our homepage shortly.' }
        format.json { render json: @directorform, status: :created, location: @directorform }
      else
        format.html { render action: "new" }
        format.json { render json: @directorform.errors, status: :unprocessable_entity }
      end 
    end
  end

  # PUT /directorforms/1
  # PUT /directorforms/1.json
  def update
    @directorform = Directorform.find(params[:id])

    respond_to do |format|
      if @directorform.update_attributes(params[:directorform])
        format.html { redirect_to @directorform, notice: 'Thank you - your form was sucessfully Updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @directorform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directorforms/1
  # DELETE /directorforms/1.json
  def destroy
    @directorform = Directorform.find(params[:id])
    @directorform.destroy

    respond_to do |format|
      format.html { redirect_to directorforms_url }
      format.json { head :no_content }
    end
  end
end
