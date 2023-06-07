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
  end

  def new
  end

  def create
  end

end
