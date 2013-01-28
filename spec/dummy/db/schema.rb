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

ActiveRecord::Schema.define(:version => 20130128033146) do

  create_table "tenantfy_tenants", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "theme",       :null => false
    t.string   "description"
    t.string   "keywords"
    t.text     "configs"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tenantfy_urls", :force => true do |t|
    t.string   "url",        :null => false
    t.integer  "tenant_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tenantfy_urls", ["tenant_id"], :name => "index_tenantfy_urls_on_tenant_id"
  add_index "tenantfy_urls", ["url"], :name => "index_tenantfy_urls_on_url", :unique => true

end
