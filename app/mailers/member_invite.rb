class MemberInvite < ActionMailer::Base
  default from: "no-reply@kidnimble.com"
  
  def send_email_non_member(user, invitee, group_id)
    @user = user
    @invitee = invitee
    @group_name = Group.find(group_id).name
    @link  = "#{members_url()}/invitatation/accept/#{(0...50).map{('a'..'z').to_a[rand(26)]}.join}-#{@user.id}"
    email_with_name = "#{@user.first_name} #{@user.last_name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "KidNimble Member Invitation")
  end
  
  def send_email_member(user, invitee, group_id)
    @user = user
    @invitee = invitee
    @group_name = Group.find(group_id).name
    @link  = "#{members_url()}/invitatation/accept/#{(0...50).map{('a'..'z').to_a[rand(26)]}.join}-#{@user.id}"
    email_with_name = "#{@user.first_name} #{@user.last_name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "KidNimble Member Invitation")
  end
  
  def send_email_confirmation(user, group_id)
    @user = user
    @group_name = Group.find(group_id).name
    email_with_name = "#{@user.first_name} #{@user.last_name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "KidNimble Member Invitation")
  end
  
end
