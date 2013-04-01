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

ActiveRecord::Schema.define(:version => 20130330223428) do

  create_table "careers", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.string   "zone_num"
    t.integer  "zone_id"
    t.integer  "tool_id"
    t.integer  "knowledge_id"
    t.integer  "skill_id"
    t.integer  "ability_id"
    t.integer  "activity_id"
    t.integer  "context_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "tasks"
  end

  create_table "careers_users", :id => false, :force => true do |t|
    t.integer "career_id"
    t.integer "user_id"
  end

  create_table "interests", :force => true do |t|
    t.string   "t3"
    t.integer  "social",        :default => 0
    t.integer  "investigative", :default => 0
    t.integer  "realistic",     :default => 0
    t.integer  "enterprising",  :default => 0
    t.integer  "conventional",  :default => 0
    t.integer  "artistic",      :default => 0
    t.integer  "career_id"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "question_id"
  end

  create_table "jobs", :force => true do |t|
    t.text     "url"
    t.string   "name"
    t.text     "description"
    t.string   "company"
    t.string   "location"
    t.date     "deadline"
    t.string   "website"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "completed",   :default => false
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "q"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "interest_id"
  end

  create_table "questions_users", :force => true do |t|
    t.integer "user_id"
    t.integer "question_id"
  end

  create_table "trends", :force => true do |t|
    t.string   "wages"
    t.string   "growth"
    t.string   "openings"
    t.string   "industries"
    t.integer  "career_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "password_digest"
    t.string   "location"
    t.string   "education"
    t.integer  "lat"
    t.integer  "lon"
    t.integer  "interest_id"
    t.integer  "total",           :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "zones", :force => true do |t|
    t.string   "title"
    t.text     "education"
    t.text     "experience"
    t.text     "training"
    t.integer  "career_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
