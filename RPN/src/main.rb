# frozen_string_literal: true

class NotExpressionError < StandardError; end

class ParenthesesError < StandardError; end

def validate_infix_expression(string)
  string_with_no_spaces = string.gsub(' ', '')
  subexpressions_indexes = find_substrings_indexes_within_parentheses(string_with_no_spaces.chars)
  if subexpressions_indexes.empty?
    pattern = %r"^\s*-?\s*\d+(\s*[+\-*/]\s*-?\s*\d+\s*)*$"
    unless string =~ pattern
      raise NotExpressionError.new "#{string} isn't a valid expression"
    end
  else
    subexpressions_indexes.each { |indexes| validate_infix_expression(string_with_no_spaces[(indexes[0] + 1)...indexes[1]]) }
  end
  string_with_no_spaces.scan(%r"(?<=^|[(+\-*/])-?\d+|[+\-*/()]")
end

def find_substrings_indexes_within_parentheses(array)
  parentheses_indexes = []
  open_parentheses = 0
  array.each_with_index do |char, index|
    if char == '('
      parentheses_indexes << index << -1 if open_parentheses.zero?
      open_parentheses += 1
    elsif char == ')'
      open_parentheses -= 1
      parentheses_indexes[-1] = index if open_parentheses >= 0
      raise(ParenthesesError, "Close parenthesis is not preceded by an opening parenthesis") if open_parentheses < 0
    end
  end
  raise(ParenthesesError, "Open parenthesis is not closed") unless open_parentheses.zero?
  parentheses_indexes.each_slice(2).to_a.each(&:freeze).freeze
end

def get_postfix_notation(infix_expression)
  operator_priorities = { 1 => %w[* /], 2 => %w[- +] }
  expression_elements = validate_infix_expression(infix_expression)
  subexpressions_indexes = find_substrings_indexes_within_parentheses(expression_elements)

  subexpressions_indexes.each do |indexes|
    expression_elements[indexes[0]] = get_postfix_notation(expression_elements[(indexes[0] + 1)...indexes[1]].join)
  end
  subexpressions_indexes.each do |indexes|
    expression_elements.slice!((indexes[0] + 1)..indexes[1])
  end

  operator_priorities.keys.each do |priority|
    while (index = expression_elements.find_index { |element| operator_priorities[priority].include? element })
      expression_elements[index - 1] += " #{expression_elements[index + 1]} #{expression_elements[index]}"
      expression_elements.slice!(index..index + 1)
    end
  end

  expression_elements[0]
end

def main
  print "Please enter your expression: "
  infix_expression = gets.chomp
  puts get_postfix_notation infix_expression
end

if __FILE__ == $0
  main
end
