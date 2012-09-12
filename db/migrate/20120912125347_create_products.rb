class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :model
      t.string :description
      t.decimal :price
      t.decimal :delivery
      t.string :url, :default => nil, :null => true
      t.datetime :deal_expiry, :default => nil, :null => true

      t.timestamps
    end
    #change_column :products, :deal_expiry, :datetime, :null => true, :default => nil
    execute "alter table products alter column deal_expiry not null;"
    
    add_index :products, [:name, :model], unique: true
  end
end
