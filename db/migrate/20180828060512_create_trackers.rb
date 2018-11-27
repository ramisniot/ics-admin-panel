class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.integer :wb_id
      t.string :part_code
      t.integer :employee_id
      t.integer :shift
      t.integer :device_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
