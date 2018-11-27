class CreateShiftMasters < ActiveRecord::Migration
  def change
    create_table :shift_masters do |t|
      t.string :shift
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
