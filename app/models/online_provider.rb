class OnlineProvider < ActiveRecord::Base
  attr_accessible :film_provider_id, :price, :price_type, :devices
  belongs_to :film_provider

  def type
    case price_type
      when 1; "PPV"
      when 2; "Subscription"
    end
  end
end
