class Film < ActiveRecord::Base
  attr_accessible :description, :image_uri, :release_date, :title, :film_rental, :certification, :summary, :director, :actors
  has_many :film_rentals

  def is_empty?
    description == nil
  end

  def image_uri_medium
    image_uri.gsub(/(\d*x\d*)/,'medium')
  end

  def image_uri_large
    image_uri.gsub(/(\d*x\d*)/,'large')
  end

  def self.json_create(o)
    new(*o['data'])
  end
end
