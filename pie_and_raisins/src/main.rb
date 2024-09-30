# frozen_string_literal: true
require_relative 'rectangle'

def find_forms(area)
  divisors = (1..Math.sqrt(area)).filter { |divisor| area % divisor == 0 }
  divisors.map do |divisor|
    dividend = area / divisor
    divisor == dividend ? [Rectangle.new(divisor, dividend)] : [Rectangle.new(divisor, dividend), Rectangle.new(dividend, divisor)]
  end.flatten.sort_by(&:width).freeze
end

def one_raisin?(piece_of_pie)
  piece_of_pie.flatten.count(1) == 1
end

def can_fit?(rectangle, shapes)
  rectangle = Rectangle.new(rectangle.width, rectangle.height)
  rectangles_to_fill = []
  shapes.each do |shape|
    return false if shape.width > rectangle.width || shape.height > rectangle.height

    rectangle = Rectangle.new(rectangle.width, rectangle.height - shape.height) if rectangle.width == shape.width
    if shape.width < rectangle.width
      rectangles_to_fill << Rectangle.new(rectangle.width, rectangle.height - shape.height) if rectangle.height - shape.height > 0
      rectangle = Rectangle.new(rectangle.width - shape.width, shape.height)
    end

    if rectangle.height == 0
      if rectangles_to_fill.empty?
        return shapes.last == shape
      end
      rectangle = rectangles_to_fill.pop
    end
  end
  false
end

def validate_pie(pie)
  cake_shape = Rectangle.new(pie.first.length, pie.length)
  flattened = pie.flatten
  number_of_raisins = flattened.count(1)

  raise 'Array must be binary' if number_of_raisins + flattened.count(0) != flattened.length
  raise 'Pie must be rectangular' unless pie.all? { |row| row.length == cake_shape.width }
  raise 'Pie must have at least two raisins and at most nine raisins' unless number_of_raisins > 1 && number_of_raisins < 10
  raise 'Cutting into equal pieces is not possible' if cake_shape.area % number_of_raisins != 0
end

def cut_pie(pie)
  validate_pie(pie)
  nil
end

def main
  cut_pie(
    [
      [1, 0, 0, 0],
      [1, 0, 0, 0],
      [0, 1, 0, 0],
    ]
  )
end

if __FILE__ == $0
  main
end
