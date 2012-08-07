class CityController < ApplicationController
  def index
    @zips = Zip.where('state = ? AND city LIKE ?', params[:state], "#{params[:term]}%").order(:city).group(:city).limit(10)
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  def zip
    @zip = Zip.where('state = ? AND city = ?', params[:state], params[:term]).first
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
