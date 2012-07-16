class FilmProvider < ActiveRecord::Base
  attr_accessible :name, :uri
  has_many :film_rentals
end
