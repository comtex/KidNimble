class OptinsMailer < ActionMailer::Base
  default from: "no-reply@kidnimble.com"

  def send_join(optin)
    @email = optin.email
    mail(:to => 'dariusgoore@gmail.com', :subject => "Opt-In List Addition").deliver
  end

end
