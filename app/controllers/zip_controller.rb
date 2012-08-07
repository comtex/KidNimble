class ZipController < ApplicationController
  def index
   @city = Zip.where(:zip => params[:term]).first
   respond_to do |format|
     format.js { render :layout => false }
   end
  end
end
