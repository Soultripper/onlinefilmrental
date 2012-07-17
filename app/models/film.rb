class Film < ActiveRecord::Base
  attr_accessible :description, :image_uri, :release_date, :title, :film_rental, :certification, :summary, :director, :actors
  has_many :film_rentals

  def add(film_provider, film_uri, reference_id)
    return if FilmRental.exists?(:film_provider_id => film_provider, :reference_id => reference_id)
    save!
    FilmRental.create! :film=>self, :film_uri => film_uri, :film_provider=>film_provider, :reference_id=>reference_id
  end

  def is_empty?
    description == nil
  end

  def image_uri_medium
    image_uri.gsub(/(\d*x\d*)/,'medium')
  end

  def image_uri_large
    image_uri.gsub(/(\d*x\d*)/,'large')
  end
end
