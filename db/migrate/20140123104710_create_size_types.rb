class CreateSizeTypes < ActiveRecord::Migration
  def change
    create_table :size_types do |t|
      t.integer :size_id
      t.integer :disk
      t.integer :cpu
      t.decimal :memory
      t.decimal :cost_per_month

      t.timestamps
    end
  end
end
