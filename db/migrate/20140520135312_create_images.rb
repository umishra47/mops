class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :hosting
      t.string :remote_image_id
      t.float :price
      t.integer :ram
      t.text :description

      t.timestamps
    end
  end
end
