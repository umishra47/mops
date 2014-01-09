class RenameColumnTypeToSubscription < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :type, :instance_type
  end
end
