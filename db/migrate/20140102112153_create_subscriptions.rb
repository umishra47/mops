class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :ami
      t.string :type
      t.date :start_date
      t.date :end_date
      t.date :notify_date
      t.references :user, index: true
      t.references :instance, index: true

      t.timestamps
    end
  end
end
