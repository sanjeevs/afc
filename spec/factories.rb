FactoryGirl.define do
  factory :product_adjust do
    amount 1
    product  
    user
  end

  factory :user do
    name "user1"
    email "nobody@example.org"
  end
  
  factory :product_return do
    amount 1
    product
    return_date "2016-04-23"
    customer
  end
  factory :product_shipment do
    amount 1
    product
    ship_date "2016-04-23"
    customer
  end

  factory :producer do
    name   'bobbees'
    email 'bobbees@example.org'
    contact 'john & patty'
  end

  factory :customer do
    name 'customer1'
  end

  factory :product do
    name 'piaz'
    amount 100
  end 

  factory :production_run do
    amount 10
    producer
    product
  end

end