class FilmRental < ActiveRecord::Base
  attr_accessible :bluray, :dvd, :online, :ppv, :reference_id, :film, :film_provider

  belongs_to :film
  belongs_to :film_provider
end
