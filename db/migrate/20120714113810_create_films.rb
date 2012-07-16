class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :title
      t.string :image_uri
      t.date :release_date
      t.string :description

      t.timestamps
    end
  end
end
