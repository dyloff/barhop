class CrawlsController < ApplicationController
  def home
    @bars = Bar.all
    @crawls = Crawl.all
  end

  def index
    @crawls = Crawl.all
    @bars = Bar.all
  end

  def new
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
