class AddParamsToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :profileId, :string
    add_column :instances, :token, :string
  end
end
