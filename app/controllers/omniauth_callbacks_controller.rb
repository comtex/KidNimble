class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    logger.info "Facebook: "+request.env["omniauth.auth"].to_yaml

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in @user
      
      saveCookiedReview if current_user
      
      redirect_to after_sign_in_path_for(resource)
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  def passthru
    #render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    raise ActionController::RoutingError.new('Not Found')
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
