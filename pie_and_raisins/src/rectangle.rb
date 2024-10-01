# frozen_string_literal: true

class Rectangle
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def area
    @width * @height
  end

  def can_be_filled_with?(shapes)
    rectangles_to_fill = []
    cur_rectangle = self
    shapes.each_with_index do |shape, i|
      break if shape.width > cur_rectangle.width || shape.height > cur_rectangle.height

      bottom_rectangle = Rectangle.new(cur_rectangle.width, cur_rectangle.height - shape.height)
      right_rectangle = Rectangle.new(cur_rectangle.width - shape.width, shape.height)

      rectangles_to_fill << bottom_rectangle if cur_rectangle.width != shape.width && bottom_rectangle.height > 0
      cur_rectangle = cur_rectangle.width == shape.width ? bottom_rectangle : right_rectangle

      if cur_rectangle.height == 0
        cur_rectangle = rectangles_to_fill.pop
        return shapes.length - 1 == i if cur_rectangle.nil?
      end
    end
    false
  end

  def ways_to_fill_with(shapes)
    shapes = shapes.select { |shape| shape.width <= @width && shape.height <= @height }
    return [] if shapes.empty?
    combinations = shapes.repeated_permutation(self.area / shapes.first.area).to_a
    combinations.select { |combination| self.can_be_filled_with? combination }
  end

end

