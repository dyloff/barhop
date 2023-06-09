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


  def filters
    if params[:venue_category].include?("restaurant") && params[:venue_category].include?("bar")
      @bars_by_venue = Bar.all
    elsif params[:venue_category].include?("restaurant")
      @bars_by_venue = Bar.all.select { |bar| bar.types.include?('restaurant') }
    else
      @bars_by_venue = Bar.all.select { |bar| !bar.types.include?('restaurant') }
    end

    # Price filter
    @bars_by_price = params[:price_range] == [""] ? Bar.all : Bar.where("price_range IN (?)", params[:price_range].drop(1))

    # All filtered
    @all_filtered_bars = @bars_by_price & @bars_by_venue

    # Number of bars requested
    @number_of_bars = params[:number_of_bars] == "" ? 3 : params[:number_of_bars].to_i
    @filtered_bars = @all_filtered_bars.sample(@number_of_bars)
  end

  def crawl_params
    params.require(:crawl).permit(:crawl_name, :completed, :public, :date)
  end
end
