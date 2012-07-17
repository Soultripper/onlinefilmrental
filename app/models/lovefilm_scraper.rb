require 'open-uri' 

module LoveFilmScraper 
  extend self

  def love_film
    FilmProvider.find_by_name('LOVEFiLM')
  end

  def import_weekly_charts(row_count) 
    url = "http://www.lovefilm.com/browse/film/uk-weekly-chart/?rows=#{row_count}"
    html = Nokogiri::HTML(open(url))
    FilmChart.delete_all
    import_film_listings html   
  end

  def import_film(film_rental_id)
    film_rental = FilmRental.where(:id=> film_rental_id).first 
    film = film_rental.film
    return film unless film.is_empty?

    html = Nokogiri::HTML(open(film_rental.film_uri))
    details = html.at_css("#panel-details")
    film.description = details.at_css('p').text.strip 
    film.save!
    return film
  end

  def import_film_listings(html)
    titles = html.css(".film_listing").each do |film_listing|
      film_rental = create_film_from_html(film_listing)
      
      next unless position = film_listing.at_css(".chart_position")
      FilmChart.where(:film_rental_id =>  film_rental.id, :position => position.text.to_i).first_or_create
    end
  end

  def create_film_from_html(html)
    film_rental = FilmRental.try_get html.at_css(".cover_link")["ref"], love_film
    return film_rental unless film_rental.new_record? 

    film = parse_film_listing_html html
    film.save!

    film_rental.film_uri = html.at_css(".cover_link")["href"]
    film_rental.film = film
    film_rental.save!
    return film_rental
  end

  def parse_film_listing_html(html_film_listing)
    html_details = html_film_listing.at_css("img")

    actors = html_film_listing.at_css(".fl_detail_info div:nth-child(4)").text.gsub(/Starring: /,'')
    director = html_film_listing.at_css(".fl_detail_info div:nth-child(5)").text.gsub(/Director: /,'')
    certification = html_film_listing.at_css(".certif img")["alt"]
    original_image_uri =  html_details[:src]
    title = html_details[:alt]
    summary = html_film_listing.at_css(".read_more").text
    release = html_film_listing.at_css(".release_decade").text.match(/.(\d*)./)[1].to_i

    image_uri = self.create_image_uri original_image_uri

    Film.new :title => title, 
      :image_uri => original_image_uri, 
      :certification=> certification, 
      :summary => summary, 
      :release_date => release,
      :director => director,
      :actors => actors
  end

  def create_image_uri(original_uri)
    original_uri.gsub(/(\d*x\d*)/,'medium')
  end
end