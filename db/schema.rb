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

ActiveRecord::Schema.define(version: 20150308033449) do

  create_table "blogposts", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "blogposts", ["created_at"], name: "index_blogposts_on_created_at"

  create_table "comments", force: true do |t|
    t.string   "content"
    t.integer  "blogpost_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educations", force: true do |t|
    t.string   "school"
    t.string   "degree"
    t.string   "major"
    t.date     "grad_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "emails", force: true do |t|
    t.string   "email"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "unsubscribe_hash"
  end

  add_index "emails", ["email"], name: "index_emails_on_email", unique: true

  create_table "employments", force: true do |t|
    t.string   "company"
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "about"
    t.string   "event_type"
    t.string   "location"
    t.string   "url"
    t.string   "image"
    t.integer  "attendees"
    t.integer  "max_attendees"
    t.datetime "date_time"
    t.string   "status"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["date_time"], name: "index_events_on_date_time"

  create_table "photos", force: true do |t|
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["imageable_id", "imageable_type"], name: "index_photos_on_imageable_id_and_imageable_type"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "school"
    t.string   "work_position"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "image"
    t.boolean  "admin"
    t.string   "resume"
    t.boolean  "private_resume"
    t.string   "goal"
    t.string   "eventbrite_oath"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "activation_token"
    t.string   "reset_digest"
    t.string   "reset_token"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
