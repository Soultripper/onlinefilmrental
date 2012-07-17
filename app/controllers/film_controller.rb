require 'lovefilm_scraper'
class FilmController < ApplicationController 
  def show
    @film = LoveFilmScraper.import_film params[:id]
    
  end
end
