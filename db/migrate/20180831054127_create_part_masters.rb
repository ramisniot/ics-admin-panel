class CreatePartMasters < ActiveRecord::Migration
  def change
    create_table :part_masters do |t|
      t.string :part_code
      t.string :part_description
      t.string :IDE_type
      t.decimal :no_of_units_per_IDE
      t.decimal :UOM
      t.decimal :weight_per_piece
      t.integer :lot_size

      t.timestamps null: false
    end
  end
end
