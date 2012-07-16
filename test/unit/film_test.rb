require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  def setup
    html = "./test/fixtures/lovefilm_weekly.html"
    @data = Nokogiri::HTML(open(html))
  end

  test "should have 50 film listings" do
    count = @data.css(".film_listing").count
    puts count
    assert count = 50
  end 

  test "add a film" do
    html_details = @data.css(".film_listing").first
    assert Film.create! :title => html_details[:alt], :image_uri => html_details[:src]
  end
end
