require 'csv'
class Tracker < ActiveRecord::Base
	belongs_to :IotDatum
	belongs_to :charts

	def self.to_csv(options = {})
		desired_columns = ["wb_id", "part_code", "employee_id", "shift", "device_id", "count", "target", "datetime"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end
end
