class CreateRegionTypes < ActiveRecord::Migration
  def change
    create_table :region_types do |t|
      t.integer :region_id
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
