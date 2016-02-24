FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "romaaan#{n}@gmail.com" }
    password "password"
    reset_password_token "qwe"
  end
end
