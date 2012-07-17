require 'test_helper'

class LoveFilmScraperTest < ActiveSupport::TestCase
  def setup
    html = "./test/fixtures/lovefilm_weekly.html"
    @data = Nokogiri::HTML(open(html))
    LoveFilmScraper.import_film_listings @data
    @film = Film.first
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
    assert_equal @film.director, "Alexander Payne", "director #{@film.director} is incorrect"
  end

  test "should have actors" do  
    assert_equal @film.actors, "George Clooney, Judy Greer, Beau Bridges, Matthew Lillard", "actors #{@film.actors} is incorrect"
  end

  test "should retrieve film details by id" do
    film_rental = @film.film_rentals.first
    VCR.use_cassette("film_#{@film.title}") do
       response = Net::HTTP.get_response(URI(film_rental.film_uri))
       html = Nokogiri::HTML(response.body)
       assert html.at_css("#panel-details")
    end
  end

  test "should have film description" do
    film_rental = @film.film_rentals.first
    VCR.use_cassette("film_#{@film.title}") do
       response = Net::HTTP.get_response(URI(film_rental.film_uri))
       html = Nokogiri::HTML(response.body)
       assert_equal html.at_css("#panel-details").at_css('p').text.strip, "A land baron tries to re-connect with his two daughters after his wife suffers a boating accident."
    end
  end
end
