FactoryGirl.define do
  factory :phone do
    association :contact
    phone { Faker::PhoneNumber.phone_number }

    factory :home_phone do
      phone_type "home"
    end

    factory :workphone do
      phone_type "workphone"
    end
    
    factory :mobile_phone do
      phone_type "mobile"
    end
  end
end