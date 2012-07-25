require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  def setup
    html = "./test/fixtures/lovefilm_weekly.html"
    @data = Nokogiri::HTML(open(html))
  end

  test "should have 50 film listings" do
    assert_equal 50, @data.css(".film_listing").count
  end 

  test "add a film" do
    html_details = @data.css(".film_listing").first
    assert Film.create! title: html_details[:alt], image_uri: html_details[:src]
  end

  test "should have a film uri" do
   html_details = @data.css(".film_listing").first
   assert_equal html_details.at_css(".cover_link")["href"], "http://www.lovefilm.com/film/The-Descendants/165239/", 'Film uris do not match'
  end
end
