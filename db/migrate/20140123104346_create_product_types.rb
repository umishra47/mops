class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.decimal :memory
      t.decimal :cost_per_month

      t.timestamps
    end
  end
end
