require 'test_helper'

class LoveFilmScraperTest < ActiveSupport::TestCase
  def setup
    html = "./test/fixtures/lovefilm_weekly.html"
    @data = Nokogiri::HTML(open(html))
    LoveFilmScraper.import_html @data
  end

  test "html should have 50 film listings" do
    assert Film.count == 50, 'the film count is incorrect'
  end 

test "html should have 50 film rentals" do
    assert FilmRental.count == 50, 'the film rental count is incorrect'
  end 

end
