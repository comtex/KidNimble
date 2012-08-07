class Order < ActiveRecord::Base
  belongs_to :events, :polymorphic => true

  def add_kid(params, user)
    if params[:kid_id]
      self.kid_id = params[:kid_id]
    else
      @kid = Kid.new
      @kid.name    = params[:kid_name]
      @kid.user_id = user.id
      @kid.born_at = params[:born_at]
      if @kid.save
        self.kid_id = @kid.id
      else
        self.errors.add(:kid, @kid.errors)
      end
    end
  end

  def process_from_saved(params,user)
    gateway = User.get_gateway()
    event = Event.find(params[:event_id])
    response = gateway.purchase(event.price, user.vault_id)
    if response.success?
      save
      OrderMailer.send_letter(self,user).deliver
    else
      errors.add(:message, response.message)
    end
    Transaction.create_from_response(response, self, user)
    @order
  end
end
