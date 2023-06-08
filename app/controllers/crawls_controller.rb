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
    # @bars_address_search = Bar.search_by_address(params[:query]) if params[:query].present?

    # bars_by_price = Bar.all.map do |bar|
    #   params[:price].contains?(bar.price_range)
    # end

    # @bars_price_range_search = Bar.filter_by_price(params[:price_range]) if params[:price_range].present?
    # @bars_venue_search = Bar.filter_by_venue(params[:venue_category]) if params[:venue_category].present?
    # @bars_number = params[:number_of_bars].to_i
    # @bars_day = params[:day]

    # @bars_address_price_venue = @bars_price_range_search & @bars_venue_search
    @bars = Bar.all
  end

  def show
    @bars = Bar.all
  end

  def create
  end

end
