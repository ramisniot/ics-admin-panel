require 'csv'
class PartMaster < ActiveRecord::Base
	
	def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(id: row["part_code"]) || new
      product.attributes = row.to_hash
      return false unless product.valid?
      product.save!
    end
  end 

  def self.to_csv(options = {})
    desired_columns = ["part_code" "part_description"	"IDE_type"	"no_of_units_per_IDE"	"UOM"	"weight_per_piece"	"lot_size"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end
end
