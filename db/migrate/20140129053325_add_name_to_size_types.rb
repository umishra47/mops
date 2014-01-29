class AddNameToSizeTypes < ActiveRecord::Migration
  def change
    add_column :size_types, :name, :string
  end
end
