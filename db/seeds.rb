# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
FilmProvider.delete_all
lovefilm = FilmProvider.create! name:"LOVEFiLM", uri:'http://www.lovefilm.com', trial_period:'one month', image_uri:'lovefilm.jpg'
netflix = FilmProvider.create! name:'Netflix', uri:'http://gan.doubleclick.net/gan_click?lid=41000613802117807&pubid=21000000000544560', trial_period:'one month', image_uri:'netflix.gif'
cp = FilmProvider.create! name:'Cinema Paradiso', uri:'http://www.cinemaparadiso.co.uk', trial_period:'2 weeks', image_uri:'cinemaparadiso.gif'
bb = FilmProvider.create! :name=> 'Blockbuster', :uri => 'http://www.blockbuster.co.uk', image_uri:'blockbuster.gif'
tesco = FilmProvider.create! :name=> 'Tesco', :uri => 'http://www.tescodvdrental.com/', image_uri:'tesco.jpg'
blinkbox = FilmProvider.create! :name=> 'Blinkbox', :uri => 'http://www.blinkbox.com/', image_uri:'blinkbox.gif'
hmv = FilmProvider.create! :name=> 'HMV', :uri => 'http://www.hmvondemand.com/', image_uri:'hmv.gif'

# Create unlimited
PostProvider.delete_all
PostProvider.create! film_provider_id:lovefilm.id, post_type:1, disc_one:{price:7.99}, disc_two:{price:9.99}, disc_three:{price:13.27}
PostProvider.create! film_provider_id:bb.id, post_type:1, disc_one:{price:7.99}, disc_two:{price:9.99}, disc_three:{price:14.99}
PostProvider.create! film_provider_id:cp.id, post_type:1, disc_one:{price:9.99}, disc_two:{price:12.99}, disc_three:{price:15.99}

# create limited
PostProvider.create! film_provider_id:lovefilm.id, post_type:2, disc_one:{price:7.99,limit:3}
PostProvider.create! film_provider_id:bb.id, post_type:2, disc_one:{price:4.99,limit:2}, disc_two:{price:5.99,limit:3}, disc_three:{price:7.99,limit:4}
PostProvider.create! film_provider_id:cp.id, post_type:2, disc_one:{price:4.99,limit:2}, disc_two:{price:5.99,limit:3}, disc_three:{price:8.16,limit:4}

#create online
OnlineProvider.delete_all
OnlineProvider.create! film_provider_id:lovefilm.id, price_type:1, price:4.99
OnlineProvider.create! film_provider_id:netflix.id, price_type:1, price:4.99
OnlineProvider.create! film_provider_id:blinkbox.id, price_type:2, price:3.49
OnlineProvider.create! film_provider_id:hmv.id, price_type:2, price:3.99