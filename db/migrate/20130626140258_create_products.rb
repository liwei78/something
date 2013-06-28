class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string   :sku
      t.string   :name
      t.text     :description
      t.string   :permalink

      t.integer  :tax_category_id
      t.integer  :shipping_category_id

      t.datetime :available_on
      t.datetime :deleted_at
      t.boolean  :blocked, :default => false  # for query opt

      t.string   :meta_keywords
      t.string   :meta_description

      t.decimal :retail_price
      t.decimal :sale_price
      t.decimal :commission_amount

      t.timestamps
    end
  end
end
