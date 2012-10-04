require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.onlinefilmrental.co.uk'
SitemapGenerator::Sitemap.create do
  add '/compare/post_limited', :changefreq => 'daily'
  add '/compare/post_unlimited', :changefreq => 'daily'
  add '/compare/online', :changefreq => 'daily'
  add '/guides/overview', :changefreq => 'monthly'
  add '/guides/introduction', :changefreq => 'monthly'
  add '/guides/monthlysubscription', :changefreq => 'monthly'
  add '/guides/payperview', :changefreq => 'monthly' 
  add '/guides/things_to_consider', :changefreq => 'monthly'
  add '/guides/summary', :changefreq => 'monthly'
  add '/reviews/lovefilm', :changefreq => 'monthly'
  add '/reviews/blockbuster', :changefreq => 'monthly'
  add '/reviews/netflix', :changefreq => 'monthly'
  add '/reviews/cinemaparadiso', :changefreq => 'monthly'

end
SitemapGenerator::Sitemap.ping_search_engines # called for you when you use the rake task