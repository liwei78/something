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

ActiveRecord::Schema.define(:version => 20130629121826) do

  create_table "csv_files", :force => true do |t|
    t.string   "file_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "sku"
    t.string   "name"
    t.text     "description"
    t.string   "permalink"
    t.integer  "tax_category_id"
    t.integer  "shipping_category_id"
    t.datetime "available_on"
    t.datetime "deleted_at"
    t.boolean  "blocked",                                            :default => false
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.decimal  "retail_price",         :precision => 8, :scale => 2
    t.decimal  "sale_price",           :precision => 8, :scale => 2
    t.decimal  "commission_amount",    :precision => 8, :scale => 2
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end