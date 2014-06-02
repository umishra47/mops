class CreateCustomImages < ActiveRecord::Migration
  def change
    create_table :custom_images do |t|
      t.string :name
      t.string :hosting
      t.string :remote_image_id
      t.float :price
      t.decimal :ram
      t.string :region_slug_do
      t.text :description

      t.timestamps
    end
  end
end
