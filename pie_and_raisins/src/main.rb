# frozen_string_literal: true

def find_forms(area)
  divisors = (1..Math.sqrt(area)).filter{ |divisor| area % divisor == 0 }
  divisors.flat_map{ |divisor| [[divisor, area / divisor], [area / divisor, divisor]] }.sort.freeze
end

def one_raisin?(piece_of_pie)
  piece_of_pie.flatten.count(1) == 1
end

def validate_pie(pie)
  rows = pie.length
  columns = pie.first.length

  area = rows * columns

  flattened = pie.flatten
  number_of_raisins = flattened.count(1)

  raise 'Array must be binary' if number_of_raisins + flattened.count(0) != flattened.length
  raise 'Pie must be rectangular' unless pie.all? { |row| row.length == columns }
  raise 'Pie must have at least two raisins and at most nine raisins' unless number_of_raisins > 1 && number_of_raisins < 10
  raise 'Cutting into equal pieces is not possible' if area % number_of_raisins != 0
end

def cut_pie(pie)
  validate_pie(pie)
  nil
end

def main
  # cut_pie(
  #   [
  #     [1, 1, 1, 1],
  #     [1, 1, 1, 1],
  #     [0, 1, 0, 0],
  #   ]
  # )
  puts find_forms(10).inspect
end

if __FILE__ == $0
  main
end
