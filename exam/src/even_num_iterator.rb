class EvenNumbersIterator
  include Enumerable

  def initialize(array)
    @array = array
  end

  def each
    @array.each do |element|
      yield element if element.even?
    end
  end
end

if __FILE__ == $0
  numbers = [1, 2, 3, 4, 4, 5, 5, 6]
  even_iterator = EvenNumbersIterator.new(numbers)

  puts even_iterator.to_a.inspect
end
