# Read about factories at http://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    sequence(:model) { |n| "Model #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    price "99.99"
    delivery 19.95
    url "http://www.ozbargain.com.au"
    
    factory :product_offer do
      deal_expiry "2013-09-12 20:53:47"
    end
  end
end
