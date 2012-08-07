require 'development_mail_interceptor'
ActionMailer::Base.smtp_settings = {
  :address              => APP.mail.address,
  :port                 => APP.mail.port,
  :domain               => APP.mail.domain,
  :user_name            => APP.mail.user_name,
  :password             => APP.mail.password,
  :authenication        => APP.mail.authenication,
  :enable_starttls_auto => APP.mail.enable_starttls_auto
}

ActionMailer::Base.default_url_options[:host] = APP.domain
ActionMailer::Base.register_interceptor DevelopmentMailInterceptor if Rails.env.development?
