class CreateWorkbenchMasters < ActiveRecord::Migration
  def change
    create_table :workbench_masters do |t|
      t.integer :machine_ID
      t.string :machine_name
      t.integer :machine_throughput
      t.string :machine_status

      t.timestamps null: false
    end
  end
end
