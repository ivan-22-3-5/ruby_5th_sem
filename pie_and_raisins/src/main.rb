# frozen_string_literal: true
require_relative 'rectangle'

def find_rectangles_of_area(area)
  divisors = (1..Math.sqrt(area)).filter { |divisor| area % divisor == 0 }

  divisors.map do |divisor|
    dividend = area / divisor
    divisor == dividend ? [Rectangle.new(divisor, dividend)] : [Rectangle.new(divisor, dividend),
                                                                Rectangle.new(dividend, divisor)]
  end.flatten.sort_by(&:width).freeze
end

def validate_pie(pie)
  raise 'Array is not valid' if pie.length == 0 or pie.first.length == 0

  cake_shape = Rectangle.new(pie.first.length, pie.length)
  flattened = pie.flatten
  number_of_raisins = flattened.count(1)

  raise 'Array must be binary' if number_of_raisins + flattened.count(0) != flattened.length
  raise 'Pie must be rectangular' unless pie.all? { |row| row.length == cake_shape.width }
  raise 'Pie must have at least two raisins and at most nine raisins' unless number_of_raisins > 1 && number_of_raisins < 10
  raise 'Cutting into equal pieces is not possible' if cake_shape.area % number_of_raisins != 0
end

def one_raisin?(piece_of_pie)
  piece_of_pie.flatten.count(1) == 1
end

def cut_off_piece!(pie, piece_shape)
  pie[0...piece_shape.height].map { |row| row.slice!(0...piece_shape.width) }
end

def cut_pie(pie)
  validate_pie(pie)
  cake_shape = Rectangle.new(pie.first.length, pie.length)

  shapes = find_rectangles_of_area(cake_shape.area / pie.flatten.count(1))
  ways_to_fill = cake_shape.ways_to_fill_with shapes

  ways_to_cut = []
  ways_to_fill.each do |way|
    pie_copy = Marshal.load(Marshal.dump(pie))
    slices = []
    way.each do |shape|
      slices << cut_off_piece!(pie_copy.reject(&:empty?), shape)
      break unless one_raisin?(slices[-1])

      ways_to_cut << slices if way.length == slices.length
    end
  end
  ways_to_cut.sort_by { |way| way.map(&:length) }.first
end

def main
  puts cut_pie([
                 [0, 1, 0, 0, 0, 0, 0],
                 [0, 0, 0, 0, 0, 0, 1],
                 [0, 0, 0, 0, 1, 0, 0],
                 [0, 0, 1, 0, 0, 0, 0]
               ]).inspect
end

if __FILE__ == $0
  main
end