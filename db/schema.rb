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

ActiveRecord::Schema.define(version: 20140701135623) do

  create_table "coloritems", force: true do |t|
    t.string   "name"
    t.string   "hex"
    t.boolean  "mixed"
    t.integer  "order"
    t.integer  "colorpalette_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coloritems", ["colorpalette_id"], name: "index_coloritems_on_colorpalette_id"

  create_table "colorpalettes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", force: true do |t|
    t.string   "name"
    t.string   "hex"
    t.boolean  "mixed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "palette_id"
  end

  add_index "colors", ["palette_id"], name: "index_colors_on_palette_id"

  create_table "palettes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end