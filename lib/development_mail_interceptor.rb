class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to      = 'keshav.kr.mishra@gmail.com'
  end
end

