class Place < ApplicationRecord
  validates :name, :description, :latitude, :longitude, :city, :state, :country, presence: true
end
