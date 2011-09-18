FactoryGirl.define do
  Factory.define :user do |u|
    u.sequence(:name) {|n| "user#{n}" }
  end
end