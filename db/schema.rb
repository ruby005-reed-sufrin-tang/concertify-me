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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140801020226) do

  create_table "artist_events", force: true do |t|
    t.integer  "artist_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artist_requests", force: true do |t|
    t.integer  "request_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artist_users", force: true do |t|
    t.integer  "artist_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb_url"
  end

  create_table "emails", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "event_requests", force: true do |t|
    t.integer  "request_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "searched_artist_id"
    t.boolean  "exact_match"
  end

  create_table "event_users", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "datetime"
    t.string   "formatted_datetime"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticket_url"
    t.string   "facebook_rsvp_url"
    t.boolean  "spotify_event",      default: false
  end

  create_table "requests", force: true do |t|
    t.string   "city"
    t.string   "state"
    t.string   "artist"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotify_artists"
  end

  create_table "spotify_artists", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "token"
  end

end
