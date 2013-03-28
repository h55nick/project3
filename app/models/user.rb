class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :education, :email, :first, :last, :lat, :location, :lon, :password, :password_confirmation
end
