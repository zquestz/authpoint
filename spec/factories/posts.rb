FactoryGirl.define do
  Factory.define :post do |p|
    p.association :user
    p.message "MyText"
  end
end