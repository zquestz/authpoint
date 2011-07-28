# factory_girl setup. woot.
FactoryGirl.define do
  
  factory :credential do
    provider 'google'
    sequence(:uid) {|n| "user#{n}@gmail.com" }
    sequence(:name) {|n| "user#{n}" }
  end
  
  factory :user do
    sequence(:name) {|n| "user#{n}" }
  end
end