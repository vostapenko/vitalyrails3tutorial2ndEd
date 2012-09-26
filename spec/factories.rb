FactoryGirl.define do
  factory :user do
    name                  "Ostapenko Vitaly"
    email                 "ostapenko.vitaly@gmail.com"
    password              "vitaly"
    password_confirmation "vitaly"
    locale                "en"
  end
end
