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

ActiveRecord::Schema.define(version: 20150430020815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credibilidades", force: :cascade do |t|
    t.integer  "valor"
    t.integer  "user_id"
    t.boolean  "enable"
    t.string   "type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "ponto_interesse_id"
    t.integer  "rota_id"
  end

  create_table "denuncias", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ponto_interesse_id"
    t.integer  "rota_id"
    t.integer  "motivo_id"
    t.string   "type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "ponto_interesses", force: :cascade do |t|
    t.string   "nome",                           null: false
    t.string   "descricao"
    t.string   "endereco",                       null: false
    t.string   "url"
    t.integer  "tipo_id"
    t.integer  "user_id"
    t.integer  "ponto_id",                       null: false
    t.boolean  "enable",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "foto"
    t.integer  "denuncias_count", default: 0
  end

  add_index "ponto_interesses", ["ponto_id"], name: "index_ponto_interesses_on_ponto_id", using: :btree
  add_index "ponto_interesses", ["tipo_id"], name: "index_ponto_interesses_on_tipo_id", using: :btree
  add_index "ponto_interesses", ["user_id"], name: "index_ponto_interesses_on_user_id", using: :btree

  create_table "pontos", force: :cascade do |t|
    t.float    "latitude",                 null: false
    t.float    "longitude",                null: false
    t.float    "altitude",   default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "tipos", force: :cascade do |t|
    t.string   "type",                      null: false
    t.string   "descricao",                 null: false
    t.string   "marcador",                  null: false
    t.boolean  "enable",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "locale"
    t.string   "gender"
    t.boolean  "enable",                 default: true
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
