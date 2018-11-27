require 'csv'
class WorkbenchMaster < ActiveRecord::Base
	belongs_to :IotDatum
	def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(id: row["machine_ID"]) || new
      product.attributes = row.to_hash
      return false unless product.valid?
      product.save!
    end
  end 

  def self.to_csv(options = {})
    desired_columns = ["machine_ID" "machine_name"	"machine_throughput"	"machine_status"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end
end
