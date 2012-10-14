# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
FilmProvider.delete_all
lovefilm = FilmProvider.create! id:1, name:"LOVEFiLM", uri:'http://www.awin1.com/awclick.php?mid=2605&id=157428', trial_period:'one month', image_uri:'lovefilm.jpg'
netflix = FilmProvider.create! id:2, name:'Netflix', uri:'http://gan.doubleclick.net/gan_click?lid=41000613802117807&pubid=21000000000544560', trial_period:'one month', image_uri:'netflix.gif'
cp = FilmProvider.create! id:3, name:'Cinema Paradiso', uri:'http://www.cinemaparadiso.co.uk', trial_period:'2 weeks', image_uri:'cinemaparadiso.gif'
bb = FilmProvider.create! id:4, :name=> 'Blockbuster', :uri => 'http://altfarm.mediaplex.com/ad/ck/12513-74081-13459-11?PID=%zp&mpre=http://www.blockbuster.co.uk/bandsignup/start-trial.aspx?cust=new&utm_source=CJ&utm_medium=affiliate&utm_campaign=other', image_uri:'blockbuster.gif'
tesco = FilmProvider.create! id:5, :name=> 'Tesco', :uri => 'http://www.tescodvdrental.com/', image_uri:'tesco.jpg'
blinkbox = FilmProvider.create! id:6, :name=> 'blinkbox', :uri => 'http://www.awin1.com/awclick.php?mid=2481&id=157428', image_uri:'blinkbox.gif'
hmv = FilmProvider.create! id:7, :name=> 'HMV', :uri => 'http://www.hmvondemand.com/', image_uri:'hmv.gif'

# Create unlimited
PostProvider.delete_all
PostProvider.create! id:1, film_provider_id:lovefilm.id, post_type:1, disc_one:{price:7.99}, disc_two:{price:9.99}, disc_three:{price:13.27}
PostProvider.create! id:2, film_provider_id:bb.id, post_type:1, disc_one:{price:7.99}, disc_two:{price:9.99}, disc_three:{price:14.99}
PostProvider.create! id:3, film_provider_id:cp.id, post_type:1, disc_one:{price:9.99}, disc_two:{price:12.99}, disc_three:{price:15.99}

# create limited
PostProvider.create! id:1, film_provider_id:lovefilm.id, post_type:2, disc_one:{price:7.99,limit:3}
PostProvider.create! id:2, film_provider_id:bb.id, post_type:2, disc_one:{price:4.99,limit:2}, disc_two:{price:5.99,limit:3}, disc_three:{price:7.99,limit:4}
PostProvider.create! id:3, film_provider_id:cp.id, post_type:2, disc_one:{price:4.99,limit:2}, disc_two:{price:5.99,limit:3}, disc_three:{price:8.16,limit:4}

#create online
OnlineProvider.delete_all
OnlineProvider.create! id:1, film_provider_id:lovefilm.id, price_type:1, price:4.99
OnlineProvider.create! id:2, film_provider_id:netflix.id, price_type:1, price:4.99
OnlineProvider.create! id:3, film_provider_id:blinkbox.id, price_type:2, price:3.49
OnlineProvider.create! id:4, film_provider_id:hmv.id, price_type:2, price:3.99