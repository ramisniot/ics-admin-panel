class CreateEmployeeProductivities < ActiveRecord::Migration
  def change
    create_table :employee_productivities do |t|
      t.integer :device_id
      t.string :device_active
      t.string :axis_data
      t.string :emp_activity
      t.string :idle
      t.string :pick

      t.timestamps null: false
    end
  end
end
