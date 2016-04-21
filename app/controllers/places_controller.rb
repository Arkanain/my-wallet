class PlacesController < ApplicationController
  load_resource find_by: :id
  authorize_resource except: [:index, :show]

  def index
  end

  def new
  end

  def create
    @place = Place.create(params[:place])

    redirect_to @place
  end

  def show
    @place = Place.preload(:wallets).find_by(id: params[:id])
  end

  def edit
  end

  def update
    @place.update(params[:place])

    redirect_to @place
  end

  def destroy
    @place.destroy

    redirect_to places_path
  end
end
