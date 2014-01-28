class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :web_name
      t.string :product_id
      t.string :name
      t.string :image_id
      t.string :status
      t.datetime :launch_time
      t.string :region
      t.string :product_type
      t.integer :size_type
      t.decimal :cost
      t.integer :region_id
      t.boolean :backups_active, :default => false
      t.string :backups
      t.string :snapshots
      t.boolean :locked, :default => false
      t.string :profileId
      t.string :dns_name
      t.references :user

      t.timestamps
    end
  end
end
