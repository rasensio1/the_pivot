class Seed

  def initialize
    @store_count = 20
    @user_count = 99
    @photo_count = 512
    create_categories
    create_users
    create_stores
    create_photos
    create_statuses
  end

  def create_categories
    @categories = %w(Abstract Animals Architecture
                Business Christmas Fashion
                Food Holidays Lifestyle Nature
                People Plants Seasons Technology
                Wedding)

    @categories.each do |category|
      Category.create(name: category)
    end
  end

  def create_users
    User.create!(name: "Josh",
                 email: "josh@turing.io",
                 password:              "password",
                 password_confirmation: "password")

    password = "password"
    @user_count.times do |n|
      name  = Faker::Name.name
      email = Faker::Internet.email
      User.create!(name:  name,
                   email: email,
                   password:              password,
                   password_confirmation: password)
    end

    User.create!(name: "Andrew",
                 email: "andrew@turing.io",
                 password:              "password",
                 password_confirmation: "password")

    User.create!(name: "Jorge",
                 email: "jorge@turing.io",
                 password:              "password",
                 password_confirmation: "password")
  end

  def create_stores
    @store_count.times do |index|
      user_id = (index + 1) * 3
      user = User.find(user_id)
      Store.create(name: user.name + "'s Photo Depot",
                    tagline: "Better than those other Photo Depots",
                    user_id: user_id)
    end
  end

  def create_photos
    image_root = "http://aws-something/"
    @photo_count.times do |index|
      Photo.create(title: "Example Title #{index + 1}",
                    description: "Fairly long and very expressive title that makes you really think about your place in life #{index + 1}",
                    standard_price: (rand(5) * 100) + 99,
                    commercial_price: ((rand(20) + 89) * 100) + 99,
                    image_url: image_root + (index + 1).to_s + ".jpg",
                    store_id: (index % 20) + 1
                    )
    end
  end

  def create_statuses
    statuses = %w(Ordered Paid Cancelled Completed)
    statuses.each do |status|
      Status.create(name: status)
    end
  end

end

seed = Seed.new
