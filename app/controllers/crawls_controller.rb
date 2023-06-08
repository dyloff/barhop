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
    @bars = Bar.all
  end

  def new
    @bars = Bar.all
    if params[:venue_category].include?("restaurant")
      @bars_by_venue = Bar.all.select { |bar| bar.types.include?('restaurant') }
    else
      @bars_by_venue = Bar.all
    end
    @bars_by_price = Bar.where("price_range IN (?)", params[:price_range].drop(1))

    @all_filtered_bars = @bars_by_price
  end

  def show
    @bars = Bar.all
  end

  def create

  end

  def filters

    # params[:price] = array
    # params[:venue_category] = array
    @bars_by_price = Bar.where("price_range ilike ?", "%#{params[:price]}")
    @bars_by_venue = Bar.where("price_range ilike ?", "%#{params[:price]}")



    # @bars_by_venue = Bar.all.map do |bar|
    #   if params[:venue_category].include?("restaurant")
    #     return bar.restaurant == true
    #   end
    # end
    # @bars_price_range_search = Bar.filter_by_price(params[:price_range]) if params[:price_range].present?
    # @bars_venue_search = Bar.filter_by_venue(params[:venue_category]) if params[:venue_category].present?
    # @bars_number = params[:number_of_bars].to_i
    # @bars_day = params[:day]

    # @bars_address_price_venue = @bars_price_range_search & @bars_venue_search
  end

end
