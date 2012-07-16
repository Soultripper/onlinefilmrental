class CreateFilmProviders < ActiveRecord::Migration
  def change
    create_table :film_providers do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
