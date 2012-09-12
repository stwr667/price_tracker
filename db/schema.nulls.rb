create_table "products", :force => true do |t|
  t.string   "name"
  t.string   "model"
  t.string   "description"
  t.decimal  "price"
  t.decimal  "delivery"
  t.string   "url"
  t.datetime "deal_expiry", :null => true, :default => nil
  t.datetime "created_at",  :null => false
  t.datetime "updated_at",  :null => false
end


