namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_products
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end


def make_products
  galaxy = Product.create!(name:     "Samsung Galaxy Nexus", model: "I9250",
                           description: "Pure Google phone with Android 4.1",
                           price: 350, delivery: 19.95, 
                           url: "http://www.kogan.com/au/buy/samsung-galaxy-nexus/?gclid=CN-T46m0ubICFcUipQodoT8ApQ",
                           deal_expiry: nil)
  99.times do |n|
    name  = Faker::Name.name
    model = "model#{n+1}"
    description = Faker::Company.catch_phrase
    price = (n + 1) * 10
    delivery = (n + 1) / 23
    url = Faker::Internet.url
    
    Product.create!(name:     name,
                    model:    model,
                    description: description,
                    price:    price,
                    delivery: delivery,
                    url:      url)
  end
end

