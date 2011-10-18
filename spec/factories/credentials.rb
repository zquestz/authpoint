FactoryGirl.define do
  Factory.define :credential do |c|
    c.association :user
    c.provider 'google_oauth2'
    c.sequence(:uid) {|n| "user#{n}@gmail.com" }
    c.sequence(:name) {|n| "user#{n}" }
  end
end