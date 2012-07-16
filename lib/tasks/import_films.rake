namespace :db do
  desc 'Import Films'
  task :import => :environment do
    LoveFilmScraper.import_weekly_charts 50
  end
end