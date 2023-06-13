require "uri"
require "net/http"
require "json"
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


def google_api_call(params = {})


  ###### DO NOT DELETE THE COMMENTED OUT CODE HERE - COMMENT IT BACK IN TO USE THE API ########

  serialized_json = URI.open("https://api.mapbox.com/geocoding/v5/mapbox.places/Hoxton.json?access_token=#{ENV['MAPBOX_API_KEY']}").read
  loc_data = JSON.parse(serialized_json)
  search_long = loc_data["features"][0]["center"][0]
  search_lat = loc_data["features"][0]["center"][1]

  if !params[:next_page_key]
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{search_lat}%2C#{search_long}&radius=2000&type=bar&key=#{ENV['GOOGLE_API_KEY']}")
  else
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{search_lat}%2C#{search_long}&radius=2000&type=bar&key=#{ENV['GOOGLE_API_KEY']}&pagetoken=#{params[:next_page_key]}")
  end

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)

  response = https.request(request)
  json_reponse = response.read_body

  JSON.parse(json_reponse)

  ##### LOCAL COPY CODE #####

  # local_json = File.read("data.json")
  # JSON.parse(local_json)

  # RETURNS A HASH
end

def place_details(google_id)
  url = URI("https://maps.googleapis.com/maps/api/place/details/json?place_id=#{google_id}&key=#{ENV['GOOGLE_API_KEY']}")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)

  response = https.request(request)
  parsed_json = JSON.parse(response.read_body)
  parsed_json["result"]
end

########### UNCOMMENT FOR 60 RESULTS ###############

full_results = []
first_api_call = google_api_call()
# sleep(3)
# second_api_call = google_api_call({ next_page_key: first_api_call["next_page_token"] })
# sleep(3)
# third_api_call = google_api_call({ next_page_key: second_api_call["next_page_token"] })
full_results << first_api_call["results"]
# full_results << second_api_call["results"]
# full_results << third_api_call["results"]

full_results = full_results.flatten

full_results.each do |result|

  ########## UNCOMMENT TO HAVE API PHOTOS ##############

  # if result["photos"][0]["photo_reference"]
    # photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{result["photos"][0]["photo_reference"]}&key=#{ENV['GOOGLE_API_KEY']}"
  # else
    photo_url = "https://loremflickr.com/cache/resized/65535_52751342904_c22b7c6469_400_400_nofilter.jpg"
  # end

    search_result_bars = []

    # if place_details(result["place_id"])["editorial_summary"] != nil
      # description = place_details(result["place_id"])["editorial_summary"]["overview"]
    # else
      description = "Further data unavailable for this location"
    # end

    temp_bar = Bar.create!(
    name: result["name"],
    types: result["types"],

    # restaurant: result["types"],

    location: result["vicinity"],
    longitude: result["geometry"]["location"]["lng"],
    latitude: result["geometry"]["location"]["lat"],
    price_range: result["price_level"] || 3,
    rating: result["rating"],
    description: description,
    image_url: photo_url,
    place_id: result["place_id"]
  )
    search_result_bars << temp_bar

end

users = ["alek", "lorenzo", "dylon", "justin"]

crawl_names=[
            "'s Big Night Out",
            "'s Regular Thursday",
            "'s Brunch Drinks",
            "'s Bank Holiday Bonanza",
            "'s Soirée",
            "'s After Work Drinks",
            "'s LeWagon Destress",
            "'s Drinks",
            "'s Crawl",
            "'s BarHop"
          ]

user_count = 0
crawl_counter = 0
users.count.times do
  user = User.create!(
    email: "#{users[user_count]}@user.com",
    password: "123456",
    username: users[user_count]
  )
  p user
  p "------------"
  1.times do
    crawl = Crawl.create!(
      crawl_name: user.username.capitalize + crawl_names.sample,
      completed: false,
      public: false,
      creator: true,
      date: nil,
      user: user
    )
    p crawl
    p "------------"
    crawl_counter += 1

    bars = Bar.all.sample(3)
    bars.each do |bar|
      crawlbar = Crawlbar.create!(
        bar: bar,
        crawl: crawl
      )
      p crawlbar
      p "------------"
    end
  end
  1.times do
    crawl = Crawl.create!(
      crawl_name: user.username.capitalize + crawl_names.sample,
      completed: false,
      public: false,
      creator: true,
      date: nil,
      user: user
    )
    p crawl
    p "------------"
    crawl_counter += 1

    bars = Bar.all.sample(rand(4..6))
    bars.each do |bar|
      crawlbar = Crawlbar.create!(
        bar: bar,
        crawl: crawl
      )
      p crawlbar
      p "------------"
    end
  end

  user_count += 1
end


random_users = ["Mura", "Raiku", "Sanman", "Sola"]

crawl_names=[
  "'s Crawl for All",
  "'s Le Wagon Alumni Drinks",
  "'s Football Social",
  "'s High End Bars",
  "'s Massive 21st",
  "'s Graduation Drinks",
  "'s Stag Night"
]

user_count = 0
crawl_counter = 0
random_users.count.times do
  user = User.create!(
    email: "#{random_users[user_count]}@user.com",
    password: "123456",
    username: random_users[user_count]
  )
  p user
  p "------------"
  1.times do
    crawl = Crawl.create!(
      crawl_name: user.username.capitalize + crawl_names.sample,
      completed: false,
      public: true,
      creator: false,
      date: nil,
      user: user
    )
    p crawl
    p "------------"
    crawl_counter += 1

    bars = Bar.all.sample(3)
    bars.each do |bar|
      crawlbar = Crawlbar.create!(
        bar: bar,
        crawl: crawl
      )
      p crawlbar
      p "------------"
    end
  end
  1.times do
    crawl = Crawl.create!(
      crawl_name: user.username.capitalize + crawl_names.sample,
      completed: false,
      public: true,
      creator: false,
      date: nil,
      user: user
    )
    p crawl
    p "------------"
    crawl_counter += 1

    bars = Bar.all.sample(rand(4..6))
    bars.each do |bar|
      crawlbar = Crawlbar.create!(
        bar: bar,
        crawl: crawl
      )
      p crawlbar
      p "------------"
    end
  end

  user_count += 1
end
