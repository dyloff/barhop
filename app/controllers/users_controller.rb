class UsersController < ApplicationController
  def dashboard
    # @crawls = Crawl.all
    @crawls = current_user.crawls
    # @bars = Bar.all
    @all_info = []

    @crawls.each do |crawl|
      all_crawl_info = {
        crawl:,
        markers: crawl.bars.geocoded.map do |bar|
          {
            lat: bar.latitude,
            lng: bar.longitude,
            # info_window_html: render_to_string(partial: "crawls/info_window", locals: { bar: bar }),
            # marker_html: render_to_string(partial: "crawls/marker")
          }
        end
      }
      @all_info << all_crawl_info
    end
    @all_info

    @favourite = Favourite.new

    @favourites = current_user.favourites
    @bars = []
    @favourites.each do |favourite|
      if  @bars.any? { |bar| bar.id == favourite.bar_id }
        index = @bars.index { |bar| bar.id == favourite.bar_id }
        @bars.delete_at(index)
      else
        @bars << Bar.find(favourite.bar_id)
      end
    end
  end
end


# def dashboard
#   @crawls = current_user.crawls

#   # @markers_all = []

#   # @crawls.each do |crawl|
#   #   @markers = crawl.bars.geocoded.map do |bar|
#   #     {
#   #       lat: bar.latitude,
#   #       lng: bar.longitude
#   #       # info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
#   #       # marker_html: render_to_string(partial: "marker")
#   #     }
#   #     @markers_all.push(@markers)
#       # raise
#     # end
#   end

#   # @crawls = Crawl.all

#   # @crawl = Crawl.all.sample

#   # @markers = @crawl.bars.geocoded.map do |bar|
#   #   {
#   #     lat: bar.latitude,
#   #     lng: bar.longitude,
#   #     # info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
#   #     # marker_html: render_to_string(partial: "marker")
#   #   }
#   # end
# # end
# end
