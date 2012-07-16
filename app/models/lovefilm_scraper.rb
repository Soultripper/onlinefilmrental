require 'open-uri'

class LoveFilmScraper
  def self.import_weekly_charts(row_count) 
    url = "http://www.lovefilm.com/browse/film/uk-weekly-chart/?rows=#{row_count}"
    html = Nokogiri::HTML(open(url))
    import_html html   
  end

  def self.import_html(html)
    titles = html.css(".film_listing").each_with_index do |film, i|
      add_film film.at_css("img")
    end
  end

  def self.add_film(html_details)
    return unless html_details
    film = Film.new(
      :title => html_details[:alt], 
      :image_uri => html_details[:src])
    film.add(love_film, html_details[:ref])
  end

  def self.love_film
    FilmProvider.find_by_name('LoveFilm')
  end
end