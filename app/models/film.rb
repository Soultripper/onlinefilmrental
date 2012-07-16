class Film < ActiveRecord::Base
  attr_accessible :description, :image_uri, :release_date, :title, :film_rental
  has_many :film_rentals

  def add(film_provider, reference_id)
    return if FilmRental.exists?(:film_provider_id => film_provider, :reference_id => reference_id)
    save!
    FilmRental.create! :film=>self, :film_provider=>film_provider, :reference_id=>reference_id
  end

end
