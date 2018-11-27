require 'csv'
class Chart < ActiveRecord::Base
	belongs_to :IotDatum
	belongs_to :WorkbenchMaster

	# def self.to_csv(options = {})
	# 	desired_columns = ["dates", "day_name", "workbench", "shift", "actual", "target", "progress"]
 #    CSV.generate(options) do |csvs|
 #      csvs << desired_columns
 #      all.each do |ds|
 #        csv << ds.attributes.values_at(*desired_columns)
 #      end
 #    end
 #  end

  def self.to_csv
    attributes = %w{dates day_name workbench shift actual target progress}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |ds|
        csv << attributes.map{ |ds| user.send(attr) }
      end
    end
  end
end
