# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"

p "destroying existing"

SharedWith.destroy_all
Review.destroy_all
Favourite.destroy_all
Follow.destroy_all
Crawlbar.destroy_all
Crawl.destroy_all
Bar.destroy_all
User.destroy_all

counter = 0

addresses = [
              " 50 -354 Old St, London EC1V 9NQ ",
              " 397-400 Geffrye St, London E2 8HZ ",
              " 1 Curtain Rd, London EC2A 3JX " ,
              " 66-68 Great Eastern St, London EC2A 3JT ",
              " 78 Hoxton St, London N1 5LH " ,
              " 2-4 Hoxton Square, London N1 6NU " ,
              " 8 Kingsland Rd, London E2 8DN " ,
              " 39A Hoxton Square, London N1 6NL ",
              " 348 Old St, London EC1V 9NQ ",
              " 70 Hoxton St, London N1 6LP ",
              " 11 Hoxton Square, London N1 6NU " ,
              " 8-9 Hoxton Square, London N1 6NU ",
              " 5 Rivington St, London EC2A 3QQ ",
              " 32 Kingsland Rd, Whitmore Estate, London E2 8AX ",
              " 0 Worship St, London EC2A 2BA ",
              "  Bishopsgate, London EC2M 4JX ",
              " 4 Bethnal Grn Rd, London E1 6JY ",
              "  Ebor St, London E1 6AW ",
              " 0-50 Willow St, London EC2A 4BH ",
              "  Kingsland Rd, London E2 8DA "
            ]
price = %w[£ ££ £££ ££££]

p "Creating new"
p "------------"
20.times do
  bar = Bar.create!(
    name: Faker::Restaurant.name,
    location: addresses[counter],
    price_range: price[rand(4)],
    rating: rand(3.0..5.0).round(1),
    description: Faker::Restaurant.description,
    image_url: "https://loremflickr.com/800/800/bar,cocktail/all"
  )
  p bar
  p "------------"
  counter += 1

  puts "This #{bar.id} doesn't have lng and lat" if bar.longitude.nil?
end

user_count = 1
crawl_counter = 1
3.times do
  user = User.create!(
    email: "user#{user_count}@user.com",
    password: "123456",
    username: "user#{user_count}"
  )
  p user
  p "------------"
  2.times do
    crawl = Crawl.create!(
      crawl_name: "Test #{crawl_counter}",
      completed: false,
      public: [true, false].sample,
      date: nil,
      user: user
    )
    p crawl
    p "------------"
    crawl_counter += 1

    3.times do
      crawlbar = Crawlbar.create!(
        bar: Bar.all.sample,
        crawl: crawl
      )
      p crawlbar
      p "------------"
    end
  end
  user_count += 1
end
