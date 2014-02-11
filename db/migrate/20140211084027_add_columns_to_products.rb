class AddColumnsToProducts < ActiveRecord::Migration
  def up
    add_column :products, :private_ssh_key, :text
    add_column :products, :public_ssh_key, :text
  end
  def down
    remove_column :products, :private_ssh_key
    remove_column :products, :public_ssh_key
  end
end
