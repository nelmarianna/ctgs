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

ActiveRecord::Schema.define(version: 20161205035735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", primary_key: "application_id", force: :cascade do |t|
    t.string   "status",            null: false
    t.integer  "registration",      null: false
    t.integer  "transportation",    null: false
    t.integer  "accommodation",     null: false
    t.integer  "meals",             null: false
    t.string   "presentationType",  null: false
    t.string   "presentationTitle", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "applications_conference", id: false, force: :cascade do |t|
    t.integer "conference_id",  null: false
    t.integer "application_id", null: false
  end

  add_index "applications_conference", ["application_id"], name: "index_applications_conference_on_application_id", using: :btree
  add_index "applications_conference", ["conference_id"], name: "index_applications_conference_on_conference_id", using: :btree

  create_table "applications_requesters", id: false, force: :cascade do |t|
    t.integer "application_id", null: false
    t.integer "requester_id",   null: false
  end

  add_index "applications_requesters", ["application_id"], name: "index_applications_requesters_on_application_id", using: :btree
  add_index "applications_requesters", ["requester_id"], name: "index_applications_requesters_on_requester_id", using: :btree

  create_table "conference", primary_key: "conference_id", force: :cascade do |t|
    t.date     "startDate",  null: false
    t.date     "endDate",    null: false
    t.string   "website",    null: false
    t.string   "location",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requesters", primary_key: "requester_id", force: :cascade do |t|
    t.string   "studNumb",      null: false
    t.string   "academicUnit",  null: false
    t.string   "program",       null: false
    t.string   "sessionNumber", null: false
    t.string   "thesisTopic",   null: false
    t.string   "bankAccNumber", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "requesters_supervisors", id: false, force: :cascade do |t|
    t.integer "supervisor_id", null: false
    t.integer "requester_id",  null: false
  end

  add_index "requesters_supervisors", ["requester_id"], name: "index_requesters_supervisors_on_requester_id", using: :btree
  add_index "requesters_supervisors", ["supervisor_id"], name: "index_requesters_supervisors_on_supervisor_id", using: :btree

  create_table "staffs", primary_key: "staff_id", force: :cascade do |t|
    t.string   "employeeNumb", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "supervisors", primary_key: "supervisor_id", force: :cascade do |t|
    t.string   "employeeNumb", null: false
    t.string   "grantAccNumb", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "loginID",                                        null: false
    t.string   "type",                                           null: false
    t.string   "firstName",              limit: 30,              null: false
    t.string   "lastName",               limit: 30,              null: false
    t.string   "grantAccNumb"
    t.string   "employeeNumb"
    t.string   "studNumb"
    t.string   "academicUnit"
    t.string   "program"
    t.string   "sessionNumber"
    t.string   "thesisTopic"
    t.string   "bankAccNumb"
    t.integer  "sup_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
