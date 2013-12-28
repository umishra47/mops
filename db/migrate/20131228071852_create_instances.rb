class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.string :name
      t.string :ec2_instance_id
      t.string :ami
      t.string :status
      t.datetime :launch_time
      t.references :user, index: true
      t.string :instance_type
      t.decimal :cost

      t.timestamps
    end
  end
end
