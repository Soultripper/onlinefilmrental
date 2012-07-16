module ScraperUtility

  def self.add_film(film, film_provider, reference_id)
    return unless film
    return if FilmRental.exists?(:film_provider => film_provider, :reference_id => reference_id)

    Film.create! film
    FilmRental.create! :film=>film, :film_provider=>film_provider, :reference_id=>reference_id
    return film
  end
end