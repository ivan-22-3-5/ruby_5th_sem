# frozen_string_literal: true
require 'date'
module Utils
  def self.parse_datetime(str, *formats)
    formats.each do |format|
      return DateTime.strptime(str.strip, format)
    end
  end
end
