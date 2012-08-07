class PostMailer < ActionMailer::Base
  default from: "no-reply@kidnimble.com"
  
  def send_email(group_id, writer, user, content)
    @group = Group.select('id, user_id, name').where(:id => group_id).first
    @user = writer
    @postowner = user
    @content = content
    @url  = groups_url()
    #@host = request.host_with_port
    mail(:to => @postowner.email, :subject => "KidNimble News Feed Added")
  end
  
  def receive(message)
    for recipient in message.to
      incoming_mail = IncomingMail.new
      incoming_mail.from_id = recipient
      incoming_mail.subject = subject
      incoming_mail.body = message.body
      
      incoming_mail.save
    end
  end
  
  /
  def receive(email) 
    page = Page.find_by_address(email.to.first)
    page.emails.create(
      :subject => email.subject,
      :body => email.body
    )
 
    if email.has_attachments?
      email.attachments.each do |attachment|
        page.attachments.create({
          :file => attachment,
          :description => email.subject
        })
      end
    end
  end
  /
  
end
