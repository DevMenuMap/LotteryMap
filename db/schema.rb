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

ActiveRecord::Schema.define(version: 20160110154209) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lotteries", force: :cascade do |t|
    t.integer  "category_id", limit: 4
    t.integer  "round",       limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "total_sales", limit: 8
  end

  add_index "lotteries", ["category_id"], name: "index_lotteries_on_category_id", using: :btree

  create_table "rank_nums", force: :cascade do |t|
    t.integer  "rank_id",    limit: 4
    t.integer  "num",        limit: 4
    t.boolean  "special",    limit: 1
    t.integer  "order",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "rank_nums", ["rank_id"], name: "index_rank_nums_on_rank_id", using: :btree

  create_table "ranks", force: :cascade do |t|
    t.integer  "lottery_id",    limit: 4
    t.integer  "rank",          limit: 4
    t.integer  "total_winners", limit: 4
    t.integer  "winning",       limit: 8
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "ranks", ["lottery_id"], name: "index_ranks_on_lottery_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "addr",       limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.decimal  "lat",                    precision: 11, scale: 8
    t.decimal  "lng",                    precision: 11, scale: 8
  end

  create_table "winners", force: :cascade do |t|
    t.integer  "store_id",   limit: 4
    t.integer  "lottery_id", limit: 4
    t.integer  "method",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "winners", ["lottery_id"], name: "index_winners_on_lottery_id", using: :btree
  add_index "winners", ["store_id"], name: "index_winners_on_store_id", using: :btree

  add_foreign_key "lotteries", "categories"
  add_foreign_key "rank_nums", "ranks"
  add_foreign_key "ranks", "lotteries"
  add_foreign_key "winners", "lotteries"
  add_foreign_key "winners", "stores"
end
