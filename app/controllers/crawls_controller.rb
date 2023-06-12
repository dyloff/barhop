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
    # params[:bar] = []
    if params[:bars].present?
      puts @filtered_bars_ids = params[:bars].split(",")
      @filtered_bars = []
      @filtered_bars_ids.each { |bar_id| @filtered_bars << Bar.find_by(place_id: bar_id) }
      @new_bars = []
      puts @filtered_bars.map(&:name)

      @filtered_bars.each_with_index do |bar, i|

        if params["bar_#{i}"] == "saved"
          @new_bars << bar
        else
          @new_bars << Bar.all.sample
        end
      end
      puts @new_bars.map(&:name)
      @markers = @new_bars.map do |bar|
        {
          lat: bar.latitude,
          lng: bar.longitude,
          # info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
          # marker_html: render_to_string(partial: "marker")
        }
      end
    else
      @filtered_bars = filters
      @filtered_bars_ids = @filtered_bars.map(&:place_id)
      @markers = @filtered_bars.map do |bar|
        {
          lat: bar.latitude,
          lng: bar.longitude,
          # info_window_html: render_to_string(partial: "info_window", locals: { bar: bar }),
          # marker_html: render_to_string(partial: "marker")
        }
      end
    end
    @crawl = Crawl.new
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'crawls/barcards_regeneration', :formats=>[:text, :html], locals: { filtered_bars: @new_bars } }
    end
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
    if params[:venue_category].include?("restaurant")
      @bars_by_venue = Bar.all
    # elsif params[:venue_category].include?("restaurant")
    #   @bars_by_venue = Bar.all.select { |bar| bar.types.include?('restaurant') }
    else
      @bars_by_venue = Bar.all.map { |bar| bar unless bar.types.include?("restaurant") }
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
