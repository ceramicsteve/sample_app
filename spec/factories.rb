FactoryGirl.define do
  factory :user do

   #passing :user symbol from user to tell the following definition is for User model object

    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

factory :admin do
  admin true

end

  end

  factory :micropost do

    content "Free Kevin"
    user
  end
end