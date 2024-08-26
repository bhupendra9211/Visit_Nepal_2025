class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.float :latitude
      t.float :longitude
      t.string :state
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
