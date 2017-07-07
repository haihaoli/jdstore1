class CreateProductlists < ActiveRecord::Migration[5.0]
  def change
    create_table :productlists do |t|
      t.integer :order_id
      t.string :product_name
      t.string :product_price
      t.integer :quantity
      t.string :product_image

      t.timestamps
    end
  end
end
