class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #validates :first_name, :last_name, :email, :password, :password_confirmation, 
  validates :first_name, :last_name, :email,
  :presence => {:message => 'Please enter a value for this field'}
  
  has_many :kids
  has_many :groups
  has_many :counselors
  has_one :review
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :token_authenticatable
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me,
    :address1, :address2, :city, :state, :zip

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      User.create!(:email => data.email, 
                    :first_name => data.first_name,
                    :last_name => data.last_name,
                    :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
        user.first_name = data["first_name"]
        user.last_name = data["last_name"]
      end
    end
  end

  def self.get_gateway()
      gateway = ActiveMerchant::Billing::BraintreeGateway.new(
        :merchant_id => APP.braintree.merchant_id,
        :public_key  => APP.braintree.public_key,
        :private_key => APP.braintree.private_key,
        :environment => APP.braintree.environment
      )
  end

  def process_order(params)
    @order              = Order.new
    @order.buyable_id   = params[:event_id]
    @order.buyable_type = 'Event'
    @order.user_id      = self.id
    @order.add_kid(params, self)

    if params[:use_saved] and self.vault_id
      @order.process_from_saved(params,self)
    else
      logger.info ":merchant_id => #{APP.braintree.merchant_id}"
      logger.info ":public_key  => #{APP.braintree.public_key}"
      logger.info ":private_key => #{APP.braintree.private_key}"
      logger.info ":environment => #{APP.braintree.environment}"

      gateway = User.get_gateway()
      creditcard = ActiveMerchant::Billing::CreditCard.new(
        :first_name         => params[:first_name],
        :last_name          => params[:last_name],
        :type               => params[:card_type],
        :number             => params[:card_number],
        :month              => params[:expiration_month],
        :year               => params[:expiration_year],
        :verification_value => params[:verification_value]
      )

      #response = gateway.purchase(1000, creditcard)
      response = gateway.store(creditcard)
      if response.success?
        self.vault_id  = response.params['customer_vault_id']
        self.card_shem = params[:card_number][-4..-1]
        self.card_type = params[:card_type]
        self.save
        @order.process_from_saved(params,self)
      else
        @order.errors.add(:message, response.message)
      end
      @order
    end
  end
  
  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:current_password)
      self.update_without_password(params)
    else
      self.verify_password_and_update(params)
    end
  end
  
  #to remove the current password check if updating a profile originally gotten via oauth (fb, twitter)
  def update_without_password(params={})

    params.delete(:password)
    params.delete(:password_confirmation)
    result = update_attributes(params)
    clean_up_passwords
    result
  end
  def verify_password_and_update(params)
    #devises' update_with_password 
    # https://github.com/plataformatec/devise/blob/master/lib/devise/models/database_authenticatable.rb
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
      update_attributes(params)
    else
      self.attributes = params
      self.valid?
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end

  # Because we have some old legacy users in the database, we need to override Devises method for checking if a password is valid.
  # We first ask Devise if the password is valid, and if it throws an InvalidHash exception, we know that we're dealing with a
  # legacy user, so we check the password against the SHA1 algorithm that was used to hash the password in the old database.
  alias :devise_valid_password? :valid_password?
  def valid_password?(password)
    begin
      devise_valid_password?(password)
    rescue BCrypt::Errors::InvalidHash
      Digest::SHA1.hexdigest(password) == encrypted_password
    end
  end


  def name
    "#{self.first_name} #{self.last_name}"
  end
end
