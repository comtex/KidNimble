class Optin < ActiveRecord::Base
  validates :email,
    :presence => true,
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
end
