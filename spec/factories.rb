FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    password "foobar"
    password_confirmation "foobar"
    factory :admin do
      admin true
    end
  end
  
  factory :customer do
    sequence(:name) { |n| "customer#{n}" }
    sequence(:email) { |n| "person_#{n}@example.org" }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zipcode { Faker::Address.zip_code }
    phone { Faker::PhoneNumber.phone_number }
  end

  factory :invalid_customer, parent: :customer do |f|
    f.name  nil
  end

  factory :supplier do
    sequence(:name) { |n| "supplier_#{n}" }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zipcode { Faker::Address.zip_code }
    phone { Faker::PhoneNumber.phone_number }
  end

  factory :producer do
    sequence(:name) { |n| "producer_#{n}" }
    email { Faker::Internet.email }
    contact { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zipcode { Faker::Address.zip_code }
    phone { Faker::PhoneNumber.phone_number }
  end

  factory :invalid_producer, parent: :producer do |f|
    f.name  nil
  end

  factory :product do
    sequence(:name) { |n| "product_#{n}" }
    amount  500 
    comment { Faker::Lorem.paragraph }

    factory :real_product do
      transient do
        num_assoc 5
      end

      after(:build) do |product, evaluator|
        create_list(:production_run, evaluator.num_assoc, product: product, amount: 199)
        create_list(:product_shipment, evaluator.num_assoc, product: product, amount: 120)
        create_list(:product_return, evaluator.num_assoc, product: product, amount: 20)
        create_list(:product_adjust, evaluator.num_assoc, product: product, amount: 1)
      end
    end
  end 
  
  factory :invalid_product, parent: :product do |f|
    f.name  nil
  end


  factory :production_run do
    amount { Faker::Number.between(1, 100) }
    mfgd_date { Faker::Date.between(Date.today - 5, Date.today) }
    expiry_date { Faker::Date.between(Date.today , Date.today + 10) }
    lot_id { Faker::Code.ean }
    producer
    product
  end

  factory :product_shipment do
    amount 0
    product
    ship_date { Faker::Date.between(Date.today - 5, Date.today) }
    customer
  end

  factory :product_return do
    amount { Faker::Number.between(1, 100) } 
    return_date { Faker::Date.between(Date.today, Date.today + 20) }
    product
    customer
  end
  
  factory :product_adjust do
    amount { Faker::Number.between(1, 100) } 
    product  
  end

  factory :supply do
    sequence(:name) { |n| "supply_#{n}" }
    amount 294 
    unit "Unit"

    factory :real_supply do
      transient do
        num_assoc 3
      end

      after(:build) do |supply, evaluator|
        create_list(:supply_consumption, evaluator.num_assoc, supply: supply, amount: 11)
        create_list(:supply_received, evaluator.num_assoc, supply: supply, amount: 110)
        create_list(:supply_adjust, evaluator.num_assoc, supply: supply, amount: -1)
      end
    end
  end

  factory :supply_received do
    amount { Faker::Number.between(100, 200) } 
    unit "Unit"
    supply
    supplier
  end

  factory :supply_consumption do
    amount { Faker::Number.between(1, 100) } 
    supply
    production_run
  end
  
  factory :supply_adjust do
    amount { Faker::Number.between(1, 100) } 
    supply 
  end



end
