# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FilmProvider.delete_all
FilmProvider.create! :name=> "LOVEFiLM", :uri=>'http://www.lovefilm.com'
FilmProvider.create! :name=> 'Netflix', :uri=>'http://www.Netflix.com'
FilmProvider.create! :name=> 'Cinema Paradiso', :uri=> 'http://www.cinemaparadiso.co.uk'
FilmProvider.create! :name=> 'Blockbuster', :uri => 'http://www.blobkbuster.co.uk'
