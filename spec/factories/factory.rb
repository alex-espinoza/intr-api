FactoryGirl.define do
  factory :user do
    sequence(:email) { |e| "email-#{e}@test.com"}
    password '123456789'
    password_confirmation '123456789'
  end
end
