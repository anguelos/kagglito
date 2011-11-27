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

ActiveRecord::Schema.define(:version => 20111127004032) do

  create_table "chalenges", :force => true do |t|
    t.binary   "gt"
    t.string   "gtfileext"
    t.binary   "input",      :limit => 255
    t.string   "name"
    t.integer  "Dataset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chalenges", ["Dataset_id"], :name => "index_chalenges_on_Dataset_id"

  create_table "competitions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "publicscore"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datasets", :force => true do |t|
    t.string   "name"
    t.boolean  "gtpublic"
    t.boolean  "inputpublic"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluators", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "minvalue"
    t.float    "maxvalue"
    t.binary   "src"
    t.integer  "User_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evaluators", ["User_id"], :name => "index_evaluators_on_User_id"

  create_table "participations", :force => true do |t|
    t.boolean  "submissionspublic"
    t.integer  "User_id"
    t.integer  "Competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["Competition_id"], :name => "index_participations_on_Competition_id"
  add_index "participations", ["User_id"], :name => "index_participations_on_User_id"

  create_table "submissions", :force => true do |t|
    t.binary   "responce"
    t.string   "responcefileext"
    t.datetime "announced"
    t.datetime "submited"
    t.float    "score"
    t.integer  "Chalenge_id"
    t.integer  "participation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submissions", ["Chalenge_id"], :name => "index_submissions_on_Chalenge_id"
  add_index "submissions", ["participation_id"], :name => "index_submissions_on_participation_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "profile"
    t.string   "password"
    t.boolean  "isadmin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
