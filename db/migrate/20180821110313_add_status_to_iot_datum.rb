class AddStatusToIotDatum < ActiveRecord::Migration
  def change
    add_column :iot_data, :status, :string
  end
end
