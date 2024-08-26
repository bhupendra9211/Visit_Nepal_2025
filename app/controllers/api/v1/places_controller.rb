class Api::V1::PlacesController < ApplicationController
  before_action :set_place, only: %i[show update]
  def index
    @places = Place.all
    render json: @places
  end
  def show
    render json: @place
  end

  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
      # render json: @place.errors.messages, status: :unprocessable_entity
      # render json: @place.errors.full_messages, status: :unprocessable_entity
      # render json: {errors: @place.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :description, :latitude, :longitude, :city, :state, :country, :image_url)
  end

end