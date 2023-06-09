class FavouritesController < ApplicationController
  def new
  end

  def create
    @bar = Bar.find(params[:bar_id])
    @favourite = Favourite.new(favourites_params)
    @favourite.user = current_user
    @favourite.bar = @bar
    @favourite.save!
    redirect_to dashboard_path
  end


  private

  def favourites_params
    params.require(:favourite).permit(:bar_id)
  end
end
