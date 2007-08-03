# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 7) do

  create_table "coaches", :force => true do |t|
    t.column "team_id",     :integer
    t.column "first_name",  :string
    t.column "last_name",   :string
    t.column "middle_name", :string
  end

  create_table "home_states", :force => true do |t|
    t.column "name", :string
  end

  create_table "leagues", :force => true do |t|
    t.column "name", :string
  end

  create_table "players", :force => true do |t|
    t.column "team_id", :integer
    t.column "name",    :string
  end

  create_table "sponsors", :force => true do |t|
    t.column "name",              :string
    t.column "spokesperson_type", :string
    t.column "spokesperson_id",   :integer
  end

  create_table "teams", :force => true do |t|
    t.column "name",          :string
    t.column "city",          :string
    t.column "sport",         :string
    t.column "home_state_id", :integer
  end

end
