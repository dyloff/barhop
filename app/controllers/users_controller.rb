class UsersController < ApplicationController
  def dashboard
    @crawls = Crawl.all
    # @bars = Bar.all
    raise
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
end
