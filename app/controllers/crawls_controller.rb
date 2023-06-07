class CrawlsController < ApplicationController
  def home
    @crawl = Crawl.all.sample

    @markers = @crawl.bars.geocoded.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {bar: bar})
      }
    end
  end

  def index
    @crawls = Crawl.all
    @bars = Bar.all
  end

  def new

    # @bars_address_search = Bar.search_by_address(params[:query]) if params[:query].present?

    bars_by_price = Bar.all.map do |bar|
      params[:price].contains?(bar.price_range)
    end

    @bars_price_range_search = Bar.filter_by_price(params[:price_range]) if params[:price_range].present?
    @bars_venue_search = Bar.filter_by_venue(params[:venue_category]) if params[:venue_category].present?
    @bars_number = params[:number_of_bars].to_i
    @bars_day = params[:day]

    @bars_address_price_venue = @bars_price_range_search & @bars_venue_search

    # if params[:price_range].present? && params[:venue_category].present? && params[:number_of_bars].present? && params[:day].present? && params[:query].present?
    #     @crawls_address_search = Crawl.search_by_address(params[:query])
    #     @crawls_price_range = Crawl.filter_by_price(params[:price_range])
    #     @crawls_venue_category = Crawl.includes(:user).joins(:user).where(users: { first_name: params[:artist] })
    #     @crawls = @crawls_p & @crawls_a

    #   elsif params[:price].present?
    #     @crawls = crawl.filter_by_price(params[:price]) if params[:price].present?
    #   elsif params[:artist].present?
    #     @crawls = crawl.includes(:user).joins(:user).where(users: { first_name: params[:artist] })
    #   else
    #     @crawls = crawl.all
    #   end

    #   if params[:query].present?
    #     @crawls = crawl.search_by_address(params[:query])
    #   else
    #     @crawls_false_search = crawl.all
    #   end
    #   @crawls_false_search = crawl.all
    #   end

    @bars = Bar.all
  end

  def show
    @bars = Bar.all
  end

  def create
  end

end

# if params[:price].present? && params[:artist].present?
#   # @artworks_s = Artwork.search_by_address(params[:query])
#   @artworks_p = Artwork.filter_by_price(params[:price])
#   @artworks_a = Artwork.includes(:user).joins(:user).where(users: { first_name: params[:artist] })
#   @artworks = @artworks_p & @artworks_a

# elsif params[:price].present?
#   @artworks = Artwork.filter_by_price(params[:price]) if params[:price].present?
# elsif params[:artist].present?
#   @artworks = Artwork.includes(:user).joins(:user).where(users: { first_name: params[:artist] })
# else
#   @artworks = Artwork.all
# end

# if params[:query].present?
#   @artworks = Artwork.search_by_address(params[:query])
# else
#   @artworks_false_search = Artwork.all
# end
# @artworks_false_search = Artwork.all
# end
