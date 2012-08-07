class SessionsController < Devise::SessionsController
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "sessions#failure")
    return sign_in_and_redirect(resource_name, resource)
  end
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    
    saveCookiedReview
    
    respond_to do |format|
      format.json do
        return render :json => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}
      end
      format.html { redirect_to stored_location_for(scope) || after_sign_in_path_for(resource) }
    end
  end

  def failure
    respond_to do |format|
      format.json do
        return render:json => {:success => false, :errors => [t("devise.failure.invalid")]}
      end
      format.html { redirect_to new_user_session_path }
    end
  end
  
  def redirect_to_back(default = root_url)
    if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end
  
  def saveCookiedReview
    @temp_reviews = TempReview.all
        
    if !@temp_reviews.blank?
      @temp_reviews.each do |temp_review|
        @review = Review.new
        @review.camp_id = temp_review.camp_id
        @review.rating = temp_review.rating
        @review.note = temp_review.note
        @review.user_id = current_user.id
        @review.url = temp_review.url
        
        if @review.save
          # Tell the ReviewMailer to send a Email after save
          ReviewMailer.send_email(@review, current_user).deliver
          
          @camp = Camp.find(temp_review.camp_id)
          @camp.rating = 0 unless @camp.rating
          @camp.raters = 1 unless @camp.raters
          @camp.rating = @camp.rating + @review.rating
          @camp.raters += 1
          @camp.save
          
          temp_review.destroy
          flash[:reviewnotice] = t("messages.review.saved")
        else
          flash[:reviewnotice] = t("messages.review.saved")
        end
      end
      
    end
  end
  
end

