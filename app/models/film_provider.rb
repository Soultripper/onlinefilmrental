class FilmProvider < ActiveRecord::Base
  attr_accessible :name, :uri, :trial_period, :image_uri
  has_many :film_rentals
  has_one :post_providers
  has_one :online_providers

  def self.find_logo_for(provider)
    find_by_name(provider).image_uri
  end
end
