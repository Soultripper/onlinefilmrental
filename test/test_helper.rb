ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'turn/autorun'
Turn.config.format = :progress
require 'vcr'

VCR.configure do |c|
  # c.default_cassette_options = {:serialize_with => :json}
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

FilmProvider.create! :name=> "LOVEFiLM", :uri=>'http://www.lovefilm.com'
FilmProvider.create! :name=> 'Netflix', :uri=>'http://www.Netflix.com'
FilmProvider.create! :name=> 'Cinema Paradiso', :uri=> 'http://www.cinemaparadiso.co.uk'
FilmProvider.create! :name=> 'Blockbuster', :uri => 'http://www.blobkbuster.co.uk'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  # Add more helper methods to be used by all tests here...
end
