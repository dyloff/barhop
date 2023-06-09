class CrawlsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]


  def home
    @crawl = Crawl.all.sample

    @markers = @crawl.bars.geocoded.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { bar: }),
        marker_html: render_to_string(partial: "marker")
      }
    end

    # puts @crawl.bars
    # puts @markers
  end
  def index

    @creators = Crawl.all.select { |crawl| crawl.creator == true }
    @public = Crawl.all.select { |crawl| crawl.public == true }
    # @public = Crawl.find_by(public: true)
    @current_friends = User.all.select do |user|
      if current_user.is_following?(user.id) && user.is_following?(current_user.id)
        user
      end
    end
    @my_friends_bars = []
    @current_friends.each do |friend|
      bars = Crawl.select { |crawl| crawl.user_id == friend.id }
      bars.each { |bar| @my_friends_bars << bar }
    end


    # @bars = Bar.all
    @creators_info = []
    @public_info = []
    @friends_info = []

    @creators.each do |crawl|
      all_crawl_info = {
        crawl:,
        markers: crawl.bars.geocoded.map do |bar|
          {
            lat: bar.latitude,
            lng: bar.longitude,
            info_window_html: render_to_string(partial: "info_window", locals: { bar: }),
            marker_html: render_to_string(partial: "marker")
          }
        end
      }

      @creators_info << all_crawl_info
    end

    clone = @public[6]
    @public.delete_at(6)
    @public = (@public.shuffle << clone)

    @public.each do |crawl|
      all_crawl_info = {
        crawl:,
        markers: crawl.bars.geocoded.map do |bar|
          {
            lat: bar.latitude,
            lng: bar.longitude,
            info_window_html: render_to_string(partial: "info_window", locals: { bar: }),
            marker_html: render_to_string(partial: "marker")
          }
        end
      }
      @public_info << all_crawl_info
    end
    @my_friends_bars.each do |crawl|
      all_crawl_info = {
        crawl:,
        markers: crawl.bars.geocoded.map do |bar|
          {
            lat: bar.latitude,
            lng: bar.longitude,
            info_window_html: render_to_string(partial: "info_window", locals: { bar: }),
            marker_html: render_to_string(partial: "marker")
          }
        end
      }
      @friends_info << all_crawl_info
    end
    @friends_info
  end

  def new
    @filters_local = filters
    # params[:bar] = []
    if params[:bars].present?
      puts "ALL FILTERED"
      puts params[:bars]
      puts @filtered_bars
      puts "-----------"

      @all_bars = @filters_local[0].map do |bar|
        Bar.new(
          name: bar.name,
          types: bar.types,
          # restaurant: bar.types,
          location: bar.location,
          longitude: bar.longitude,
          latitude: bar.latitude,
          price_range: bar.price_range,
          rating: bar.rating,
          place_id: bar.place_id,
          description: bar.description,
          image_url: bar.image_url
        )
      end
      # raise

      puts "This is @filtered_bars_ids"
      puts @filtered_bars_ids = params[:bars].split(",")
      @filtered_bars_ids = params[:bars].split(",")

      puts "all bars"
      @all_bars.each { |bar| puts bar.place_id }
      puts "---------------------"

      @filtered_bars = []
      @filtered_bars_ids.each do |bar_id|
        puts "--------------------"
        puts "bar_id"
        puts bar_id
        @all_bars.each do |bar|
          if bar.place_id == bar_id
            @filtered_bars << bar
            puts "bar"
            puts bar.place_id
            puts bar
          end
        end
      end
      puts "this is the filtered bars array"
      puts @filtered_bars


      puts "This is @filtered_bars.map(&:name)"
      puts (@filtered_bars.map{ |bar| bar.name })


      @new_bars = []

      @filtered_bars.each_with_index do |bar, i|
        if params["bar_#{i}"] == "saved"
          @new_bars << bar
        else
          new_regen_bar = bar
          until !@filtered_bars.include?(new_regen_bar)
            new_regen_bar = @all_bars.sample
          end
          until !@new_bars.include?(new_regen_bar)
            new_regen_bar = @all_bars.sample
          end
          @new_bars << new_regen_bar
        end
      end

      @new_bars_ids = @new_bars.map { |bar| bar.place_id }

      # puts @new_bars.map(&:name)
      @markers = @new_bars.map do |bar|
        {
          lat: bar.latitude,
          lng: bar.longitude,
          info_window_html: render_to_string(inline: "<div><%= bar.name %></div>", locals: { bar: bar }),
          # marker_html: render_to_string(partial: "marker")
        }
      end

      # raise
    else

      @all_bars = @filters_local[0]
      @number_of_bars = @filters_local[1]
      @filtered_bars = @all_bars.sample(@number_of_bars)


      @all_bars_info = []

      @all_bars.each do |bar|
        @all_bars_info << bar.attributes
      end

      @filtered_bars_ids = @filtered_bars.map(&:place_id)
      @markers = @filtered_bars.map do |bar|
        {
          lat: bar.latitude,
          lng: bar.longitude,
          info_window_html: render_to_string(inline: "<div><%= bar.name %></div>", locals: { bar: bar }),
          # marker_html: render_to_string(partial: "marker")
        }
      end
    end

    # * Connected with the generate() in reload.js stimulus
    @crawl = Crawl.new
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text do
        puts "These bars from generate() fetch"
        # puts @new_bars
        puts @new_bars[0].name
        puts @new_bars[1].name
        puts @new_bars[2].name

        @filters_local = filters
        @all_bars = @filters_local[0]

        @all_bars_info = []

        @all_bars.each do |bar|
          @all_bars_info << bar.attributes
        end

        new_crawl = {
          crawl: @crawl,
          # markers: @new_bars.geocoded.map do |bar|
          markers: @new_bars.map do |bar|
                     {
                       lat: bar.latitude,
                       lng: bar.longitude,
                       info_window_html: render_to_string(inline: "<div><%= bar.name %></div>", locals: { bar: bar }),
                      #  marker_html: render_to_string(partial: "marker")
                     }
                   end
        }

        puts new_crawl
        puts new_crawl[:markers]

        # render partial: "crawls/barcards_regeneration", formats: %i[text html], locals: { filtered_bars: @new_bars }
        # render partial: "shared/map", locals: { markers: new_crawl[:markers] }
        puts

        render partial: "crawls/gen_crawl", formats: %i[text html], locals: { filtered_bars: @new_bars, markers: new_crawl[:markers], bars_full_info: @all_bars_info }
        # render partial: "crawls/gen_crawl", formats: %i[text html], locals: { markers: new_crawl[:markers] }

        # raise
      end
    end

    # raise
  end

  def show
    @crawl = Crawl.find(params[:id])
    @markers = @crawl.bars.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { bar: }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def create

    @crawl = Crawl.new(crawl_params)
    @crawl.user = current_user
    @crawl.save!

    if params[:crawl][:existing_crawl] == "true"

      crawlbar_ids = eval(params[:crawl][:bars])
      bars = crawlbar_ids.map { |id| Crawlbar.find(id).bar }

      bars.each do |bar|
        temp = Crawlbar.new()
        temp.bar = bar
        temp.crawl = @crawl
        temp.save!
      end


    else

  bar_info = eval(params[:crawl][:bars_full_info].gsub("} {", "}, {").insert(0, "[").insert(-1, "]"))
  @all_bars = bar_info.map do |bar|
    Bar.create!(
      name: bar["name"],
      types: bar["types"],
      # restaurant: bar["types"],
      location: bar["location"],
      longitude: bar["longitude"],
      latitude: bar["latitude"],
      price_range: bar["price_range"],
      rating: bar["rating"],
      place_id: bar["place_id"],
      description: bar["description"],
      image_url: bar["image_url"]
    )
  end
  puts "all bars in create"
  puts @all_bars

    # @all_bars = @all_bars_hash.map do |bar|
    # Bar.new(
    #   name: bar["name"],
    #   types: bar["types"],
    #   # restaurant: bar["types"],
    #   location: bar["location"],
    #   longitude: bar["longitude"],
    #   latitude: bar["latitude"],
    #   price_range: bar["price_range"],
    #   rating: bar["rating"],
    #   place_id: bar["place_id"],
    #   description: bar["description"],
    #   image_url: bar["image_url"]
    # )
    # end

    @selected_bar_place_ids = params[:crawl][:bars_ids].split()

    puts "selected bar place ids in create"
    puts @selected_bar_place_ids

    @selected_bars = []
    @selected_bar_place_ids.each do |bar_place_id|
      @selected_bars << @all_bars.find { |bar| bar.place_id == bar_place_id }
    end

    @selected_bars.each do |bar|
      temp = Crawlbar.new()
      temp.crawl = @crawl
      temp.bar = bar
      temp.save!
    end
  end

      # @bars = eval(params[:crawl][:bars]).map do |id|
      #   Crawlbar.find(id).bar
      # end
  # end

#     @bars = params[:crawl][:bars].split
#     @bars.each do |id|
#       bar = Bar.find(id.to_i)
#       crawl_bar = Crawlbar.new
    # @bars.each do |bar|
    #   crawl_bar = Crawlbar.new()
    #   crawl_bar.bar = bar
    #   crawl_bar.crawl = @crawl
    #   crawl_bar.save
    # end

    redirect_to dashboard_path
  end


  # def map
  #   @markers = @new_bars.map do |bar|
  #     {
  #       lat: bar.latitude,
  #       lng: bar.longitude,
  #       # info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
  #       # marker_html: render_to_string(partial: "marker")
  #     }
  #   end

  #   respond_to do |format|
  #     # raise
  #     format.html { render partial: "shared/map", locals: { markers: @markers } }
  #   end
  # end
  # def destroy
  #   @crawl = Crawl.find(params[:id])
  #   @crawl.destroy
  #   redirect_to dashboard_path, status: :see_other
  # end


  private

  def filters
    @master_bar_list = retrieve_bars_from_api
    # @master_bar_list = Bar.all

    if params[:venue_category].include?("restaurant")
      @bars_by_venue = @master_bar_list
      # elsif params[:venue_category].include?("restaurant")
      #   @bars_by_venue = Bar.all.select { |bar| bar.types.include?('restaurant') }
    else
      @bars_by_venue = @master_bar_list.map { |bar| bar unless bar.types.include?("restaurant") }
    end

    # Price filter
    if params[:price_range] == [""]
      @bars_by_price = @master_bar_list
    else
      @bars_by_price = @master_bar_list.select do |bar|
        params[:price_range].drop(1).include?(bar.price_range)
      end
    end

    ## This no longer works because it uses Active Record
    # @bars_by_price = params[:price_range] == [""] ? @master_bar_list : Bar.where("price_range IN (?)", params[:price_range].drop(1))

    # All filtered
    @all_filtered_bars = @bars_by_price & @bars_by_venue

    # LIMITS THE BARS TO 10 MAX OUTPUT
    # @all_filtered_bars = @all_filtered_bars.first(10) if @all_filtered_bars.length > 10


    ### THIS NOW ADDS THE DESCRIPTION ONLY TO THE BARS WE USE TO MINIMIZE API CALLS ###

    @all_filtered_bars.each do |bar|
      if place_details(bar.place_id)["editorial_summary"] != nil
        bar.description = place_details(bar.place_id)["editorial_summary"]["overview"]
      else
        bar.description = "Further data unavailable for this location"
      end
    end


    # Number of bars requested
    @number_of_bars = params[:number_of_bars] == "" ? 3 : params[:number_of_bars].to_i
    # @filtered_bars = @all_filtered_bars.sample(@number_of_bars)
    @filtered_bars = [@all_filtered_bars, @number_of_bars]

  end

  def google_api_call(pars = {})
    # User input formatting
    location_input = params[:query] == "" ? "London" : params[:query].gsub(" ", "_")

    # Geocode location long/lat
    serialized_json = URI.open("https://api.mapbox.com/geocoding/v5/mapbox.places/#{location_input}.json?access_token=#{ENV.fetch(
      'MAPBOX_API_KEY', nil
    )}").read
    loc_data = JSON.parse(serialized_json)
    search_long = loc_data["features"][0]["center"][0]
    search_lat = loc_data["features"][0]["center"][1]

    # Google API call with long/lat
    if !pars[:next_page_key]
      url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{search_lat}%2C#{search_long}&radius=2000&type=bar&key=#{ENV.fetch('GOOGLE_API_KEY', nil)}")
    else
      url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV.fetch('GOOGLE_API_KEY', nil)}&pagetoken=#{pars[:next_page_key]}")
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
    full_results << first_api_call["results"]

    sleep(2.5)
    second_api_call = google_api_call({ next_page_key: first_api_call["next_page_token"] })
    full_results << second_api_call["results"]

    # sleep(2.5)
    # third_api_call = google_api_call({ next_page_key: second_api_call["next_page_token"] })
    # full_results << third_api_call["results"]

    full_results = full_results.flatten
    search_result_bars = []

    full_results.each do |result|
      ###### UNCOMMENT TO HAVE API PHOTOS ######

    if result["photos"]
      photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{result["photos"][0]["photo_reference"]}&key=#{ENV['GOOGLE_API_KEY']}"
    else
      photo_url = "https://loremflickr.com/cache/resized/65535_52751342904_c22b7c6469_400_400_nofilter.jpg"
    end

    ### TEMP DESCRIPTION ALLOCATION IN CASE THE DESCRIPTION DOESNT WORK LATER IN THE PROCESS ###

    description = "Further data unavailable for this location"

      puts result

      temp_bar = Bar.new(
        name: result["name"],
        types: result["types"],
        # restaurant: result["types"],
        location: result["vicinity"],
        longitude: result["geometry"]["location"]["lng"],
        latitude: result["geometry"]["location"]["lat"],
        price_range: result["price_level"] || 3,
        rating: result["rating"],
        place_id: result["place_id"],
        description: description,
        image_url: photo_url
      )
      search_result_bars << temp_bar
    end

    search_result_bars.uniq
  end

  def place_details(google_id)
    url = URI("https://maps.googleapis.com/maps/api/place/details/json?place_id=#{google_id}&key=#{ENV.fetch(
      'GOOGLE_API_KEY', nil
    )}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    parsed_json = JSON.parse(response.read_body)
    parsed_json["result"]
  end

  def crawl_params
    params.require(:crawl).permit(:crawl_name, :completed, :public, :date)
  end
end
