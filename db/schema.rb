# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120714114229) do

  create_table "film_providers", :force => true do |t|
    t.string   "name"
    t.string   "uri"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "film_rentals", :force => true do |t|
    t.integer  "film_provider_id"
    t.integer  "film_id"
    t.string   "reference_id"
    t.boolean  "dvd"
    t.boolean  "bluray"
    t.boolean  "online"
    t.boolean  "ppv"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "film_rentals", ["film_provider_id", "film_id"], :name => "index_film_rentals_on_film_provider_id_and_film_id"

  create_table "films", :force => true do |t|
    t.string   "title"
    t.string   "image_uri"
    t.date     "release_date"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
