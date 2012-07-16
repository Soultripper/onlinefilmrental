class CreateFilmRentals < ActiveRecord::Migration
  def change
    create_table :film_rentals do |t|
      t.references :film_Provider
      t.references :film
      t.boolean :dvd
      t.boolean :bluray
      t.boolean :online
      t.boolean :ppv

      t.timestamps
    end
    add_index :film_rentals, :film_provider_id
    add_index :film_rentals, :film_id
  end
end
