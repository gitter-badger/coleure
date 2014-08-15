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

ActiveRecord::Schema.define(version: 20140815183115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colors", force: true do |t|
    t.string   "name"
    t.string   "hex"
    t.boolean  "mixed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "palette_id"
    t.string   "rgb"
    t.string   "hsl"
    t.integer  "position"
  end

  add_index "colors", ["palette_id"], name: "index_colors_on_palette_id", using: :btree

  create_table "palettes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "parent_id"
  end

  create_table "users", force: true do |t|
    t.string   "name",                            null: false
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.boolean  "verified",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
