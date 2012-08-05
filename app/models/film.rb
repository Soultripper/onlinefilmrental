class Film < ActiveRecord::Base
  attr_accessible :description, :image_uri, :release_date, :title, :film_rental, :certification, :summary, :director, :actors
  has_many :film_rentals

  def is_empty?
    description == nil
  end

  def image_uri_medium
    no_image? ? image_uri.gsub(/(\d*x\d*)/,'lrg2') : image_uri.gsub(/(\d*x\d*)/,'medium')
  end

  def image_uri_large
    no_image? ? image_uri : image_uri.gsub(/(\d*x\d*)/,'large')
  end

  def self.json_create(o)
    new(*o['data'])
  end

  def no_image?
    image_uri.include? 'no_cover'
  end

end
