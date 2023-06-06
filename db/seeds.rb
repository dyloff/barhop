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
            "32 London Bridge Street Southwark London SE1 9SG",
            "45 Oxford Street Westminster London W1D 2DZ",
            "18 Baker Street Marylebone London W1U 3BS",
            "9 Downing Street Westminster London SW1A 2AA",
            "76 Regent Street Westminster London W1B 5RL",
            "5 Leicester Square Westminster London WC2H 7NA",
            "21 Piccadilly Westminster London W1J 0BH",
            "14 Trafalgar Square Westminster London WC2N 5DU",
            "29 Coventry Street Westminster London W1D 7DT",
            "33 Haymarket Westminster London SW1Y 4LR",
            "2 Buckingham Palace Road Westminster London SW1W 0PP",
            "8 Parliament Square Westminster London SW1P 3JX",
            "17 Fleet Street City of London London EC4Y 1AA",
            "11 Downing Street Westminster London SW1A 2AB",
            "26 Whitehall Westminster London SW1A 2WH",
            "20 Kensington High Street Kensington and Chelsea London W8 4PE",
            "42 Knightsbridge Westminster London SW1X 7JU",
            "1 The Mall Westminster London SW1A 2QH",
            "10 Downing Street Westminster London SW1A 2AA",
            "37 Grosvenor Square Westminster London W1K 2HU",
            "9 Chelsea Embankment Kensington and Chelsea London SW3 4LE",
            "24 Savile Row Westminster London W1S 2ET",
            "6 Pall Mall Westminster London SW1Y 5NG",
            "31 St James's Street Westminster London SW1A 1HD",
            "7 Portobello Road Kensington and Chelsea London W11 3DA",
            "23 King's Road Kensington and Chelsea London SW3 4RP",
            "3 Notting Hill Gate Kensington and Chelsea London W11 3JQ",
            "12 Marylebone High Street Marylebone London W1U 4PG",
            "28 Old Bond Street Westminster London W1S 4QF",
            "19 Park Lane Westminster London W1K 1PN"
          ]

price = %w[£ ££ £££ ££££]

p "Creating new"
p "------------"
30.times do
  bar = Bar.create(
    name: Faker::Restaurant.name,
    location: addresses[counter],
    price_range: price[rand(4)],
    rating: rand(0.0..5.0).round(1),
    description: Faker::Restaurant.description,
    image_url: "https://loremflickr.com/800/800/bar,cocktail/all"
  )
  p bar
  p "------------"
  counter += 1
end
