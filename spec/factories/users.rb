FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    mobile { Faker::PhoneNumber.cell_phone }
    trait :admin do
      role 'admin'
    end
  end
end
