require './app/models/lovefilm_scraper'
WebMock.disable!   
namespace :db do
  desc 'Import Films'
  task :import => :environment do 
    LoveFilmScraper.new.import_weekly_charts 50
  end
end