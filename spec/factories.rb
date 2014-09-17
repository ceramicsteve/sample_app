FactoryGirl.define do
  factory :user do #passing :user symbol from user to tell the following definition is for User model object
    name "Stephen Wong"
    email "stephen.wong.cme@gmail.com"
    password "foobar"
    password_confirmation "foobar"

  end
end