require 'open-uri' 

class LoveFilmScraper 
  
  def love_film
    FilmProvider.find_by_name('LOVEFiLM')
  end

  def get_html(uri)
    Nokogiri::HTML(open(uri))
  end

  def search(query)
    # query.gsub! ' ', '%2B'
    # html = get_html "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%20%3D%20'http%3A%2F%2Fwww.lovefilm.com%2Fbrowse%2Ffilm%2F%3Fquery%3D" + query + "%26rows%3D50'&diagnostics=true"
    query.gsub! ' ', '+'
    html = get_html "http://www.lovefilm.com/browse/film/?query=#{query}&rows=50"
  # throw "http://www.lovefilm.com/search/results/?query=#{query}&rows=50"
    films= import_film_listings html
  end

  def import_weekly_charts(row_count) 
    html = get_html "http://www.lovefilm.com/browse/film/uk-weekly-chart/?rows=#{row_count}"
    FilmChart.delete_all
    import_film_listings html   
  end

  def import_film_listings(html)
    films_found = Array.new()

    titles = html.css(".fl_detail").each do |film_listing|
      film_rental = create_film_from_listing(film_listing)      
      try_add_film_chart film_listing, film_rental.id
      films_found << film_rental
    end

    films_found
  end

  def create_film_from_listing(html)
    film_rental = FilmRental.try_get reference_id(html), love_film
    return film_rental unless film_rental.new_record? 

    film = parse_film_listing_html html
    film.save!

    film_rental.film_uri = html.at_css(".cover_link")["href"]
    film_rental.film = film
    film_rental.save!
    return film_rental
  end

  def parse_film_listing_html(html)
    begin
      actors = get_text(html, ".fl_detail_info div:nth-child(4)").gsub(/Starring: /,'')
      director = get_text(html, ".fl_detail_info div:nth-child(5)").gsub(/Director: /,'')
      certification = html.at_css(".certif img")["alt"]
      summary = get_text(html, ".read_more")

      html_details = html.at_css("img")
      original_image_uri =  html_details[:src]
      title = html_details[:alt]
      
      Film.new title: title, 
        image_uri: original_image_uri, 
        certification: certification, 
        summary: summary, 
        release_date: release_year(html),
        director: director,
        actors: actors
    rescue Exception => e
      puts html
    end

  end

  def try_add_film_chart(html, film_rental_id)
    return unless position = html.at_css(".chart_position")
    FilmChart.where(film_rental_id: film_rental_id, position: position.text.to_i).first_or_initialize.save!
  end
  
  def get_film(film_rental_id)
    film_rental = FilmRental.where(:id => film_rental_id).first 
    film = film_rental.film
    return film unless film.is_empty? 

    update_film film_rental  
  end

  def update_film(film_rental)
    html = get_html film_rental.film_uri

    details = html.at_css("#panel-details")

    film = film_rental.film
    film.description = get_text(details, 'p:not(.feedback_text)') 
    film.save!
    return film
  end

  def release_year(film_listing)

    value = film_listing.at_css(".release_decade")
    return value ? value.text.strip.match(/.(\d*)./)[1].to_i : value
  end

  def reference_id(film_listing)
    return unless film_listing
    link = film_listing.at_css(".cover_link")
    link['href'].match(/.(\d+)\/$/)[1] unless link.blank?
  end

  def get_text(html, selector)
    data =html.at_css(selector)
    data ? data.text.strip : ''
  end
end