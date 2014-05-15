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

ActiveRecord::Schema.define(version: 20140514235623) do

  create_table "albums", force: true do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums_artists", force: true do |t|
    t.integer  "artist_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists_songs", force: true do |t|
    t.integer  "song_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chart_top100_years", force: true do |t|
    t.integer  "year"
    t.integer  "song_id"
    t.string   "title"
    t.string   "artist"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
    t.integer  "album_id"
    t.string   "clip"
  end

  create_table "trivia_question_types", force: true do |t|
    t.string   "text"
    t.string   "answer_model"
    t.string   "answer_property"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trivia_questions", force: true do |t|
    t.string   "uuid"
    t.integer  "trivia_question_type_id"
    t.integer  "user_id"
    t.integer  "song_id"
    t.integer  "album_id"
    t.integer  "artist_id"
    t.boolean  "is_correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
