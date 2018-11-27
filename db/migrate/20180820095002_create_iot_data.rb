class CreateIotData < ActiveRecord::Migration
  def change
    create_table :iot_data do |t|
      t.integer :workbench_number
      t.string :part_number
      t.integer :target
      t.integer :lot_size
      t.string :employee_name
      t.integer :employee_id
      t.string :shift
      t.integer :device_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
