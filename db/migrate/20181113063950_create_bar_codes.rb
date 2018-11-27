class CreateBarCodes < ActiveRecord::Migration
  def change
    create_table :bar_codes do |t|
      t.string :asn
      t.string :part_code
      t.integer :qty
      t.date :date
      t.integer :lot_size
      t.integer :target
      t.string :location

      t.timestamps null: false
    end
  end
end
