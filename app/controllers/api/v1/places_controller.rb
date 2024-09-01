class Api::V1::PlacesController < ApplicationController
  before_action :set_place, only: %i[show update destroy]
  # # This index is performing n+1 query we can resolve n+1 query using eager loading
  # # we need to do eager loading when we are dealing with parent with their associated data
  # def index
  #   @places = Place.all
  #   # render json: @places
  #   # render json: @places.as_json(include: :images)
  #   render json: @places.as_json(include: {images: {only: %i[id url]}})
  #   # render json: @places.map {|place| place.as_json(include: {images: {only: %i[id url]}})}
  # end
  def index
    @places = Place.includes(:images)
    render json: @places.as_json(include: { images: {only: %i[id url]}})
  end
  def show
    # render json: @place
    # render json: @place.as_json(include: :images)
    render json: @place.as_json(include: { images: { only: %i[id url] } } )
  end
  def create
    @place = Place.new(place_params)
    if @place.save
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
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
  def destroy
    @place.destroy
    render json: {status: 'success', message: 'place has been deleted successfully'}
  end

  private

  def set_place
    @place = Place.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: { message: error.message, status: 'failed' }
  end

  def place_params
    params.require(:place).permit(:name, :description, :latitude, :longitude, :city, :state, :country, :image_url)
  end

end