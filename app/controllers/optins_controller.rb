class OptinsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    optin = Optin.new
    optin.email = params[:email]
    optin.save!
    OptinsMailer.send_join(optin)
    respond_to do |format|
      format.json { render json: ['Thank you!'] }
    end
  end
end
