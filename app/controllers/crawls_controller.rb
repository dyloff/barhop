require "uri"
require "open-uri"
require "net/http"
require "json"

class CrawlsController < ApplicationController
  def home
    @crawl = Crawl.all.sample

    @markers = @crawl.bars.geocoded.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def index
    @crawls = Crawl.all
    # @bars = Bar.all

    @all_info = []

    @crawls.each do |crawl|
      all_crawl_info = {
        crawl:,
        markers: crawl.bars.geocoded.map do |bar|
          {
            lat: bar.latitude,
            lng: bar.longitude,
            info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
            marker_html: render_to_string(partial: "marker")
          }
        end
      }
      @all_info << all_crawl_info
    end
    @all_info
  end

  def new
    @filtered_bars = filters
    @markers = filters.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
        marker_html: render_to_string(partial: "marker")
      }
    end
    @crawl = Crawl.new
  end

  def show
    @crawl = Crawl.find(params[:id])
    @markers = @crawl.bars.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def create
    @crawl = Crawl.new(crawl_params)
    @crawl.user = current_user
    @crawl.save!
    @bars = params[:crawl][:bars].split()
    @bars.each do |id|
      bar = Bar.find(id.to_i)
      crawl_bar = Crawlbar.new()
      crawl_bar.bar = bar
      crawl_bar.crawl = @crawl
      crawl_bar.save
    end

    redirect_to dashboard_path
  end

  private

  def filters
    if params[:venue_category].include?("restaurant")
      @all_bars_test = retrieve_bars_from_api
      @bars_by_venue = retrieve_bars_from_api
    # elsif params[:venue_category].include?("restaurant")
    #   @bars_by_venue = Bar.all.select { |bar| bar.types.include?('restaurant') }
    else
      @bars_by_venue = retrieve_bars_from_api.map { |bar| bar unless bar.types.include?("restaurant") }
    end

    # Price filter
    if params[:price_range] == [""]
      @bars_by_price = retrieve_bars_from_api
    else
      @bars_by_price = retrieve_bars_from_api.select do |bar|
        params[:price_range].drop(1).include?(bar.price_range)
      end
    end

    ## This no longer works because it uses Active Record
    # @bars_by_price = params[:price_range] == [""] ? retrieve_bars_from_api : Bar.where("price_range IN (?)", params[:price_range].drop(1))

    # All filtered
    @all_filtered_bars = @bars_by_price & @bars_by_venue

    raise
    # Number of bars requested
    @number_of_bars = params[:number_of_bars] == "" ? 3 : params[:number_of_bars].to_i
    @filtered_bars = @all_filtered_bars.sample(@number_of_bars)
  end

  def google_api_call( pars = {} )
    # User input formatting
    location_input = params[:query].gsub(" ", "_")

    # Geocode location long/lat
    serialized_json = URI.open("https://api.mapbox.com/geocoding/v5/mapbox.places/#{location_input}.json?access_token=#{ENV['MAPBOX_API_KEY']}").read
    loc_data = JSON.parse(serialized_json)
    search_long = loc_data["features"][0]["center"][0]
    search_lat = loc_data["features"][0]["center"][1]

    # Google API call with long/lat

    if !pars[:next_page_key]
      url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{search_lat}%2C#{search_long}&radius=2000&type=bar&key=#{ENV['GOOGLE_API_KEY']}")
    else
      url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV['GOOGLE_API_KEY']}&pagetoken=#{pars[:next_page_key]}")
    end

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    json_reponse = response.read_body

    JSON.parse(json_reponse)
    # RETURNS A HASH
  end

  def retrieve_bars_from_api
    full_results = []
    first_api_call = google_api_call
    sleep(3)
    second_api_call = google_api_call({ next_page_key: first_api_call["next_page_token"] })
    sleep(3)
    third_api_call = google_api_call({ next_page_key: second_api_call["next_page_token"] })
    full_results << first_api_call["results"]
    full_results << second_api_call["results"]
    full_results << third_api_call["results"]

    full_results = full_results.flatten
    search_result_bars = []
    full_results.each do |result|

    ########## UNCOMMENT TO HAVE API PHOTOS ##############

    # if result["photos"][0]["photo_reference"]
      # photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{result["photos"][0]["photo_reference"]}&key=#{ENV['GOOGLE_API_KEY']}"
    # else
      photo_url = "https://loremflickr.com/cache/resized/65535_52751342904_c22b7c6469_400_400_nofilter.jpg"
    # end


      temp_bar = Bar.new(
        name: result["name"],
        types: result["types"],

        # restaurant: result["types"],

        location: result["vicinity"],
        longitude: result["geometry"]["location"]["lng"],
        latitude: result["geometry"]["location"]["lat"],
        price_range: result["price_level"] || 3,
        rating: result["rating"],
        description: Faker::Restaurant.description,         # "TO SCRAPE"
        image_url: photo_url
      )
      search_result_bars << temp_bar
    end
    search_result_bars.uniq
  end

  def crawl_params
    params.require(:crawl).permit(:crawl_name, :completed, :public, :date)
  end
end
