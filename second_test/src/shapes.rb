# frozen_string_literal: true

class Shape
  def initialize
    raise NotImplementedError
  end

  def area
    raise NotImplementedError
  end
end

class Square < Shape
  def initialize(side)
    @side = side
  end

  def area
    @side * @side
  end
end

class Triangle < Shape
  def initialize(base, height)
    @base = base
    @height = height
  end

  def area
    @base * @height / 2
  end
end

if __FILE__ == $0
  square = Square.new(5)
  triangle = Triangle.new(3, 4)
  puts square.area
  puts triangle.area
end