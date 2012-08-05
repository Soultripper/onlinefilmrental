module FilmHelper

  def title_with_release_date
    "#{@film.title} #{release_date}" 
  end

  def release_date
    @film.release_date ? "(#{@film.release_date})" : nil 
  end

end
