namespace :db do
  desc "Fill database with users" 
  task populate_users: :environment do
    admin =  User.create!(name: "sanjeev",
                password: "foobar",
                password_confirmation: "foobar")
    admin.toggle!(:admin)

    99.times do |n|
      name = Faker::Name.name
      password = "foobar"
      User.create!(name: name,
                   password: password, password_confirmation: password)
    end
  end
end
