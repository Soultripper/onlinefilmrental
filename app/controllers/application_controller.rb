class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @films = FilmChart.all
  end
end
