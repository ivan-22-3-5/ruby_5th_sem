# frozen_string_literal: true

module Utils
  def self.my_reverse(array)
    array.each_index.map { |i| array[-(i + 1)] }
  end
end
