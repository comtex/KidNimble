class OrderMailer < ActionMailer::Base
  default from: "no-reply@kidnimble.com"
  def send_letter(order, user)
    @user  = user
    @order = order
    @event = Event.find(@order.buyable_id)
    mail(:to => user.email, :subject => "KidNimble.com: Your Order")
  end
end
