class AddRegionToCustomImages < ActiveRecord::Migration
  def change
    add_column :custom_images, :region, :string
  end
end
