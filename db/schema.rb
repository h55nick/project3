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

ActiveRecord::Schema.define(:version => 20130527143043) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

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
    t.integer  "growth_num"
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
    t.integer  "growth_num"
  end

  create_table "users", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "password_digest"
    t.string   "location"
    t.string   "education"
    t.integer  "lat"
    t.integer  "lon"
    t.integer  "interest_id"
    t.integer  "total",                  :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "l_token"
    t.string   "l_secret"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.string   "email",                  :default => "", :null => false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

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
