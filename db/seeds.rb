class Seed

  def initialize
    @store_count       = 20
    @user_count        = 99
    @photo_count       = 301
    @order_count       = 500
    @order_items_count = 2500
    create_categories
    create_users
    create_stores
    create_photos
    create_statuses
    create_orders
    create_order_items
    create_photo_categories
  end

  def create_photo_categories
    seed_photo_categories = [1, 1, 1, 2, 6, 5, 2, 6, 5, 3, 4, 7, 3, 6, 6, 6, 6, 5, 6, 8, 6, 8, 7, 2, 8, 6, 7, 7, 6, 5, 6, 6, 2, 7, 6, 6, 7, 2, 7, 6]
    @photo_count.times do |index|
      PhotoCategory.create(photo_id: (index + 1), category_id: seed_photo_categories[(index + 1) % seed_photo_categories.size])
    end
  end

  def create_categories
    @categories = %w(Animals Architecture
                Fashion Food
                Lifestyle Nature
                People Technology)

    @categories.each do |category|
      Category.create(name: category)
    end
  end

  def create_users
    User.create!(name:                  "Josh",
                 email:                 "josh@turing.io",
                 password:              "password",
                 password_confirmation: "password")

    password = "password"
    @user_count.times do |n|
      name  = Faker::Name.name
      email = Faker::Internet.email
      User.create!(name:                  name,
                   email:                 email,
                   password:              password,
                   password_confirmation: password)
    end

    User.create!(name:                  "Andrew",
                 email:                 "andrew@turing.io",
                 password:              "password",
                 password_confirmation: "password")

    User.create!(name:                  "Jorge",
                 email:                 "jorge@turing.io",
                 password:              "password",
                 password_confirmation: "password")

    User.create!(name:                  "Platform Admin Jr.",
                 email:                 "pa@turing.io",
                 password:              "password",
                 password_confirmation: "password")
  end

  def create_stores
    @store_count.times do |index|
      user_id = (index + 1) * 3
      user    = User.find(user_id)
      Store.create(name:    user.name + "'s Photo Depot",
                   tagline: "Better than those other Photo Depots",
                   user_id: user_id)
    end

    Store.create(name:    "Andrew's Photo HyperMegaMart",
                 tagline: "Bargain photo's for those who don't need the best, or even close.",
                 user_id: User.find_by(email: "andrew@turing.io").id
    )
  end

  def create_photos
    # @photo_count.times do |index|

    File.open("#{Rails.root}/spec/fixtures/photo_urls.txt").readlines.each_with_index do |line, index|
      photo = Photo.create(title:            "Example Title #{index + 1}",
                           description:      "Fairly long and very expressive title that makes you really think about your place in life #{index + 1}",
                           standard_price:   (rand(5) * 100) + 99,
                           commercial_price: ((rand(20) + 89) * 100) + 99,
                           store_id:         Store.all.sample.id)
      photo.update_column(:file, line.chomp)
    end

    Photo.create(title:            "Andrew's One Photo",
                 description:      "You really only need this photo.",
                 standard_price:   500,
                 commercial_price: 200,
                 file:             File.open("#{Rails.root}/spec/fixtures/test_photo_1.jpg"),
                 store_id:         User.find_by(email: "andrew@turing.io").store.id)
  end

  def create_statuses
    statuses = %w(Ordered Paid Cancelled Completed)
    statuses.each do |status|
      Status.create(name: status)
    end
  end

  def create_orders
    @order_count.times do
      Order.create(user_id:   User.all.sample.id,
                   status_id: Status.find_by(name: "Completed").id)
    end
  end

  def create_order_items
    @order_items_count.times do
      OrderItem.create(order_id: Order.all.sample.id,
                       photo_id: Photo.all.sample.id,
                       quantity: 1)
    end
  end

end

seed = Seed.new
