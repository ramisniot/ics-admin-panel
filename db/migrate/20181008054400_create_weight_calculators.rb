class CreateWeightCalculators < ActiveRecord::Migration
  def change
    create_table :weight_calculators do |t|
      t.string :part_code
      t.decimal :wpp
      t.decimal :count
      t.integer :idm
      t.decimal :mpq

      t.timestamps null: false
    end
  end
end
