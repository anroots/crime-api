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

ActiveRecord::Schema.define(version: 20131225132751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friend_links", force: true do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.string  "value"
  end

  create_table "online_players", force: true do |t|
    t.string   "username"
    t.string   "world",      default: "valge"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "activity",   default: 0.0
    t.string   "color",      default: "666666"
    t.integer  "fame",       default: 0
  end

  create_table "players", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",   default: "null"
    t.integer  "fame",       default: 0
    t.integer  "mining",     default: 0
    t.string   "world"
    t.boolean  "banned",     default: false
  end

end
