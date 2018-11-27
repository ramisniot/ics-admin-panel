require 'csv'

class Import < ActiveRecord::Base
  belongs_to :IotDatum
  belongs_to :PartMaster
  validates_uniqueness_of :part_number, :message => "^Friendly field name is blank Import"

	def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      
      product = find_by(id: row["workbench_number"]) || new
      product.attributes = row.to_hash
      product.save!
    end
  end 

  def self.to_csv(options = {})
    desired_columns = ["workbench_number", "part_number", "target", "lot_size", "employee_name", "employee_id", "shift", "device_id", "count", "status"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end
end


