# frozen_string_literal: true

class NotExpressionError < StandardError; end

class ParenthesesError < StandardError; end

def validate_infix_expression(infix_expression)
  parentheses_indexes = find_top_level_parentheses_indexes(infix_expression.chars)
  parentheses_indexes.each { |indexes| validate_infix_expression(infix_expression[(indexes[0] + 1)...indexes[1]]) }

  real_number_pattern = %r"\s*-?\s*\d+(\.\d+)?"
  operator_pattern = %r"\s*[+\-*/]\s*"

  expression_pattern = %r"^#{real_number_pattern}(#{operator_pattern}#{real_number_pattern})*$"

  unless infix_expression.gsub(%r'[()]', '') =~ expression_pattern
    raise NotExpressionError.new "#{infix_expression} isn't a valid expression"
  end
end

def find_top_level_parentheses_indexes(array)
  parentheses_indexes = []
  open_parentheses = 0
  array.each_with_index do |char, index|
    case char
    when '('
      parentheses_indexes << index << -1 if open_parentheses.zero?
      open_parentheses += 1
    when ')'
      open_parentheses -= 1
      parentheses_indexes[-1] = index if open_parentheses >= 0
      raise(ParenthesesError, "Close parenthesis is not preceded by an opening parenthesis") if open_parentheses < 0
    end
  end
  raise(ParenthesesError, "Open parenthesis is not closed") unless open_parentheses.zero?
  parentheses_indexes.each_slice(2).to_a.each(&:freeze).freeze
end

def tokenize_expression(expression)
  operator_pattern = %r"[+\-*/]"
  float_pattern = %r"(?<=^|\(|#{operator_pattern})-?\d+\.\d+"
  integer_pattern = %r"(?<=^|\(|#{operator_pattern})-?\d+"

  expression.gsub(' ', '').scan(%r"#{float_pattern}|#{integer_pattern}|#{operator_pattern}|[()]")
end

def get_postfix_notation(infix_expression)
  operator_priorities = { 1 => %w[* /], 2 => %w[- +] }
  validate_infix_expression(infix_expression)

  expression_elements = tokenize_expression(infix_expression)
  parentheses_indexes = find_top_level_parentheses_indexes(expression_elements)

  parentheses_indexes.each do |indexes|
    expression_elements[indexes[0]] = get_postfix_notation(expression_elements[(indexes[0] + 1)...indexes[1]].join)
  end
  parentheses_indexes.each { |indexes| expression_elements.slice!((indexes[0] + 1)..indexes[1]) }

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
