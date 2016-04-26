FactoryGirl.define do
  factory :address do
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zipcode { Faker::Address.zip_code }
    phone { Faker::PhoneNumber.phone_number }
  end

  factory :customer do
    sequence(:name) { |n| "customer#{n}" }
    sequence(:email) { |n| "person_#{n}@example.org" }
  end
  
  factory :supplier do
    sequence(:name) { |n| "supplier_#{n}" }
    :address
  end

  factory :supply_consumption do
    amount 1
    supply
    production_run
  end
  factory :supply_received do
    amount 1
    unit "MyString"
    supply
    supplier
  end

  factory :supply do
    name "Tamarind"
    amount 14
    unit "kg"
  end

  factory :product_adjust do
    amount 13
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
