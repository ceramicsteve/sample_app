class User < ActiveRecord::Base

  before_save {self.email = email.downcase} #lowercase email address before save
  validates(:name, presence: true, length: {maximum: 50}) #user name is true max length of 50 characters
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # all Caps is a constant, is a regular expression
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
            #uniqueness is true with case sensitive of the address false

  has_secure_password #makes the password in to a hash, i guess it takes the :password string and turns it in to a hash that passes to :pasword_confirmation

  validates :password, length: {minimum: 6}
end
