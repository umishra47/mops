class AddCustomImageIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :custom_image_id, :integer
  end
end
