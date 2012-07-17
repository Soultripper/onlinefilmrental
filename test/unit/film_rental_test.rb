require 'test_helper'

class FilmRentalTest < ActiveSupport::TestCase

  test "add a film rental" do
    assert FilmRental.create! :film=>Film.first, :film_uri=>'http://www.test.com', :film_provider=>FilmProvider.first, :reference_id=> 'test'
  end
end
