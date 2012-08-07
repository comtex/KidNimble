class DealsController < InheritedResources::Base
  def show
    @deals = Deal.where(:camp_id => params[:id])
    respond_to do |format|
      format.json { render json: @deals }
    end
  end
end
