require 'test_helper'

class LoveFilmScraperTest < ActiveSupport::TestCase
  def setup
    # uri = "./test/fixtures/lovefilm_weekly.html"
    uri = "http://www.lovefilm.com/browse/film/uk-weekly-chart/?rows=50"

    VCR.use_cassette("lovefilm_weekly") do 
      @data = Nokogiri::HTML(open(uri))      
    end

    LoveFilmScraper.new.import_film_listings @data
    @film_chart = FilmChart.where(:position=>1).first
    @film_rental = @film_chart.film_rental
    @film = @film_chart.film
  end

  test "html should have 50 film listings" do
    assert Film.count == 50, "the film count is incorrect -> it is #{Film.count}"
  end 

  test "html should have 50 film rentals" do
      assert FilmRental.count == 50, 'the film rental count is incorrect'
  end 

  test "should have release date" do  
    assert @film.release_date == 2011, 'release date is incorrect'
  end

  test "should have director" do  
    assert_equal "Alexander Payne", @film.director, "director #{@film.director} is incorrect"
  end

  test "should have actors" do  
    assert_equal "George Clooney, Judy Greer, Beau Bridges, Matthew Lillard", @film.actors, "actors #{@film.actors} is incorrect"
  end

  test "should retrieve film details by id" do
    VCR.use_cassette("film_#{@film.title}") do
       html = Nokogiri::HTML(open(@film_rental.film_uri))
       assert html.at_css("#panel-details")
    end
  end

  test "should have film description" do
    VCR.use_cassette("film_#{@film.title}") do
       html = Nokogiri::HTML(open(@film_rental.film_uri))
       assert_equal html.at_css("#panel-details").at_css('p').text.strip, 
       "A land baron tries to re-connect with his two daughters after his wife suffers a boating accident."
    end
  end

  test "search for Ice Age should have 30 results" do
    html = ""
    VCR.use_cassette("search_ice_age") do
       uri = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%20%3D'http%3A%2F%2Fwww.lovefilm.com%2Fbrowse%2Ffilm%2F%3Fquery%3Dice%2Bage%26rows%3D50'&diagnostics=true"
       html = Nokogiri::HTML(open(uri))       
    end
    films = LoveFilmScraper.import_film_listings html
    assert_equal films.count, 15, 'incorrect film count for search Ice Age'
  end
end
