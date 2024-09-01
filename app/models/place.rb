class Place < ApplicationRecord
  validates :name, :description, :latitude, :longitude, :city, :state, :country, presence: true
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images, reject_if: proc { |attributes| attributes['url'].blank? }
end
