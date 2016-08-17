FactoryGirl.define do

  factory :user do
    trait :with_attributes do
      name "Mike"
      email "mike@gmail.com"
      password "asdfasdf"
    end

    trait :without_attributes do
    end

    trait :invalid_attributes do
      name ""
      email ""
      password ""
    end

    trait :for_controller do
      name "Mike"
      sequence :email do |n|
        "mike#{n}@gmail.com"
      end
      password "asdfasdf"
    end

  end

  factory :secret do
    trait :with_attributes do
      title "The Secret"
      body "This is a secret."
    end

    trait :without_attributes do
    end

    association :author, factory: :user, name: "Mike", email: "mike@gmail.com", password: "asdfasdf"

  end

end
