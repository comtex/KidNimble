class ReviewMailer < ActionMailer::Base
  default from: "no-reply@kidnimble.com"
  
  def send_email(review, user)
    @review = review
    @camp = Camp.find(@review.camp_id)
    @user = user
    if !@camp.blank? && @camp.contact_email.blank?
      @camp.contact_email = "no-reply@kidnimble.com";
    end 
    mail(:to => @camp.contact_email, :subject => "KidNimble Review Added")
  end
  
end
