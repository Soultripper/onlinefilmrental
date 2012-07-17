class CreateFilmCharts < ActiveRecord::Migration
  def change
    create_table :film_charts do |t|
      t.integer :position
      t.references :FilmRental

      t.timestamps
    end
    add_index :film_charts, :FilmRental_id
  end
end
