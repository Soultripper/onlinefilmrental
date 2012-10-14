require 'lovefilm_scraper'
class FilmController < ApplicationController 

  
  def show
    @film = LoveFilmScraper.new.get_film params[:id]
  end

  def search
    @films = LoveFilmScraper.new.search(params[:query]).uniq
  end

  def create
    film_provider= FilmProvider.find_by_name('LOVEFiLM')

    params[:_json].each do |film_params|
      reference_id = film_params.delete :reference_id

      film_rental = FilmRental.try_get reference_id, film_provider
      next unless film_rental.new_record?

      film = Film.create JSON.parse film_params.to_json      
      film_rental.film = film
      film_rental.save!
      logger.debug "this is what I have #{film.title}"    
    end
    render :json => ''
  end
end
