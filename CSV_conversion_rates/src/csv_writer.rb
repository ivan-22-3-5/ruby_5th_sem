# frozen_string_literal: true
require 'csv'
module CSVWriter
  def write_csv(filename, header, data)
    CSV.open(filename, "w") do |csv|
      csv << header
      data.each { |row|
        raise ArgumentError, "All rows must have the same length as the header" if row.length != header.length
        csv << row
      }
    end
  end
end
