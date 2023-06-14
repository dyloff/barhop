class UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]

  def dashboard
    # @crawl = Crawl.find(params[:id])
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
    @markers = @favourites.map { |favourite| {
      lat: favourite.bar.latitude,
      lng: favourite.bar.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { favourite: favourite }),
      # marker_html: render_to_string(partial: "marker")
    }}
    @bars = []
    @favourites.each do |favourite|
      if  @bars.any? { |bar| bar.id == favourite.bar_id }
        index = @bars.index { |bar| bar.id == favourite.bar_id }
        @bars.delete_at(index)
      else
        @bars << Bar.find(favourite.bar_id)
      end
    end
    #friends
    @friends = friends
  end

  def friends
    @users = User.all.select do |user|
      if current_user.is_following?(user.id) && user.is_following?(current_user.id)
        user
      end
    end
    @users
  end

  def index
    @users = User.where.not(id: current_user.id)
  end

  def follow
    if current_user.follow(@user.id)
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js
      end
    end
  end

  def unfollow
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js { render action: :follow }
      end
    end
  end

  def destroy
    @crawl = Crawl.find(params[:id])
    @crawl.destroy
    redirect_to dashboard_path, status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
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
