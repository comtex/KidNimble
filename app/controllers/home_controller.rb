class HomeController < ApplicationController
	def index
	  @categories = Category.where("id > 0").order(:name)
	  @subcategory = Subs.where(:category_id => 0).order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
	end

	def about

	end
  
  def comingsoon
    
  end
end
