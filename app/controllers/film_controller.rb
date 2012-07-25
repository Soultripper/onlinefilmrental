require 'lovefilm_scraper'
class FilmController < ApplicationController 
  def show
    @film = LoveFilmScraper.get_film params[:id]
    
  end
end
