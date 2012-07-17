class FilmRental < ActiveRecord::Base
  attr_accessible :bluray, :dvd, :online, :ppv, :reference_id, :film, :film_provider, :film_uri

  belongs_to :film
  belongs_to :film_provider

  def self.try_get(reference_id, film_provider)
    FilmRental.where(:reference_id => reference_id, :film_provider_id => film_provider).first_or_initialize
  end

end
