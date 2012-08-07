class Transaction < ActiveRecord::Base
  def self.create_from_response(response, order, user)
    t = Transaction.new
    t.user_id       = user.id
    t.order_id      = order.id if order and order.id
    t.success       = response.success?
    t.message       = response.message
    t.authorization = response.authorization
    t.response      = response.inspect
    t.save
    t
  end
end
