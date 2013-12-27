class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :image_id
      t.string :image_state
      t.boolean :is_public

      t.timestamps
    end
  end
end
