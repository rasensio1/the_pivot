class Seed

  def initialize
    @store_count       = 20
    @user_count        = 99
    @photo_count       = 301
    @order_count       = 500
    @order_items_count = 2500
    create_users
    create_stores
    create_photos
    create_categories
    create_statuses
    create_orders
    create_order_items
    create_photo_categories
    create_platform_admin
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

    # User.create!(name:                  "platform admin",
    #              email:                 "pa@turing.io",
    #              password:              "password",
    #              password_confirmation: "password",
    #              platform_admin:        true)

    User.create!(name:                  "Josh",
                 email:                 "josh@turing.io",
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
                 user_id: User.find_by(email: "andrew@turing.io").id)
  end

  def create_photos
    File.open("#{Rails.root}/spec/fixtures/photo_urls.txt").readlines.each_with_index do |line, index|
      photo = Photo.new(title:          "Example Title #{index + 1}",
                        description:    "Fairly long and very expressive title that makes you really think about your place in life #{index + 1}",
                        standard_price: (rand(5) * 100) + 99,
                        store_id:       Store.all.sample.id)

      photo.save(validate: false)
      photo.update_column(:file, line.chomp)
      puts("Photo: #{index}")
    end

    Photo.create(title:          "Andrew's One Photo",
                 description:    "You really only need this photo.",
                 standard_price: 500,
                 file:           File.open("#{Rails.root}/spec/fixtures/test_photo_1.jpg"),
                 store_id:       User.find_by(email: "andrew@turing.io").store.id)
  end

  def create_statuses
    statuses = %w(Ordered Paid Cancelled Completed)
    statuses.each do |status|
      Status.create(name: status)
    end
  end

  def create_orders
    @order_count.times do |index|
      Order.create(user_id:   User.all.sample.id,
                   status_id: Status.find_by(name: "Completed").id)
      puts "Order: #{index}"
    end
  end

  def create_order_items
    @order_items_count.times do |index|
      photo_id = Photo.all.sample.id
      OrderItem.create(order_id: Order.all.sample.id,
                       photo_id: photo_id,
                       quantity: 1,
                       sale_amount: Photo.find(photo_id).standard_price)
      puts "OrderItem: #{index}"
    end
  end

  def create_platform_admin
    User.create!(name:                  "Platform Admin Jr.",
                 email:                 "pa@turing.io",
                 password:              "password",
                 password_confirmation: "password",
                 platform_admin:        true)
  end

end

seed = Seed.new
