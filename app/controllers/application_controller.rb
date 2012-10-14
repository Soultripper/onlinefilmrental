require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery

  caches_page :index
  def index
    @films = FilmChart.order(:position).limit(10)
  end
end
