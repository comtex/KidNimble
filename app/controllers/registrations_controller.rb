class RegistrationsController < Devise::RegistrationsController
  @current_resource
  def create
    build_resource

    if resource.save
      @current_resource = resource
      saveCookiedReview if !@current_resource.blank?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_in_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

   if resource.update_with_password(params[resource_name])
     set_flash_message :notice, :updated if is_navigational_format?
     sign_in resource_name, resource, :bypass => true
     respond_with resource, :location => after_sign_in_path_for(resource)
   else
     clean_up_passwords(resource)
     respond_with_navigational(resource){ render :edit }
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
        @review.user_id = @current_resource.id
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

