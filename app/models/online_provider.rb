class OnlineProvider < ActiveRecord::Base
  attr_accessible :film_provider_id, :price, :price_type, :devices
  belongs_to :film_provider
end
