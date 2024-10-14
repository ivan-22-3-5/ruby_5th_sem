# frozen_string_literal: true
require 'csv'
module CSVWriter
  def write_csv(filename, header, data)
    raise ArgumentError, "All rows must have the same length as the header" if data.any? { |r| r.length != header.length }
    CSV.open(filename, "w") do |csv|
      csv << header
      data.each { |row| csv << row }
    end
  end
end
