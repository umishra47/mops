class CreateInstanceTypes < ActiveRecord::Migration
  def change
    create_table :instance_types do |t|
      t.string :name
      t.decimal :memory
      t.decimal :cost

      t.timestamps
    end
  end
end
