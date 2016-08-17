FactoryGirl.define do

  factory :user do
    trait :with_attributes do
      sequence(:name){ |n| "Mike#{n}"}
      email "#{name}@gmail.com"
      password "asdfasdf"
    end

    trait :without_attributes do
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
