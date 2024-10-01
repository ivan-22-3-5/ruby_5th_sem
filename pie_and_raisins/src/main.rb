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

def one_raisin?(piece_of_pie)
  piece_of_pie.flatten.count(1) == 1
end

def can_fit?(rectangle, shapes)
  rectangles_to_fill = []

  shapes.each_with_index do |shape, i|
    break if shape.width > rectangle.width || shape.height > rectangle.height

    bottom_rectangle = Rectangle.new(rectangle.width, rectangle.height - shape.height)
    right_rectangle = Rectangle.new(rectangle.width - shape.width, shape.height)

    rectangles_to_fill << bottom_rectangle if rectangle.width != shape.width && bottom_rectangle.height > 0
    rectangle = rectangle.width == shape.width ? bottom_rectangle : right_rectangle

    if rectangle.height == 0
      rectangle = rectangles_to_fill.pop
      return shapes.length - 1 == i if rectangle.nil?
    end
  end
  false
end

def find_ways_to_fit_shapes(rectangle, shapes)
  shapes = shapes.select { |shape| shape.width <= rectangle.width && shape.height <= rectangle.height }
  return [] if shapes.empty?
  combinations = shapes.repeated_permutation(rectangle.area / shapes.first.area).to_a
  combinations.select { |shape_comb| can_fit?(rectangle, shape_comb) }
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

def cut_off_piece!(pie, piece_shape)
  pie[0...piece_shape.height].map { |row| row.slice!(0...piece_shape.width) }
end

def cut_pie(pie)
  validate_pie(pie)
  cake_shape = Rectangle.new(pie.first.length, pie.length)

  shapes = find_rectangles_of_area(cake_shape.area / pie.flatten.count(1))
  ways_to_fit = find_ways_to_fit_shapes(cake_shape, shapes)

  ways_to_cut = []
  ways_to_fit.each do |way|
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