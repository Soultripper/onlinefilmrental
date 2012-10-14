require './app/models/lovefilm_scraper'
WebMock.disable!   
  desc 'Import Films'
  task :get_chart => :environment do 
    LoveFilmScraper.new.import_weekly_charts 50
  end
