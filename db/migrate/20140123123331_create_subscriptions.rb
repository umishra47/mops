class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :type
      t.string :image_id
      t.string :product_type
      t.integer :size_type
      t.date :start_date
      t.date :end_date
      t.date :notify_date
      t.references :user, index: true
      t.references :product, index: true
      t.string :status

      t.timestamps
    end
  end
end
