json.array!(@trackers) do |tracker|
  json.extract! tracker, :id, :wb_id, :part_code, :employee_id, :shift, :device_id, :count
  json.url tracker_url(tracker, format: :json)
end
