# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100506122058) do

  create_table "questions", :force => true do |t|
    t.text     "text",        :null => false
    t.integer  "response_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", :force => true do |t|
    t.integer  "question_id", :null => false
    t.string   "text",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses_results", :id => false, :force => true do |t|
    t.integer "response_id", :null => false
    t.integer "result_id",   :null => false
  end

  create_table "results", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "textile",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
