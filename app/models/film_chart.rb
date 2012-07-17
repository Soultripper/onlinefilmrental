class FilmChart < ActiveRecord::Base
  belongs_to :film_rental
  delegate :film, :to => :film_rental
  attr_accessible :position, :film_rental_id
end
