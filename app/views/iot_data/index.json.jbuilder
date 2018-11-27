json.array!(@iot_data) do |iot_datum|
  json.extract! iot_datum, :id, :workbench_number, :part_number, :target, :lot_size, :employee_name, :employee_id, :shift, :device_id, :count
  json.url iot_datum_url(iot_datum, format: :json)
end
