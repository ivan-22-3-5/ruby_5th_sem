# frozen_string_literal: true

class NotExpressionError < StandardError; end

def get_postfix_notation(infix_expression)
  operator_priorities = { 1 => %w[* /], 2 => %w[- +] }
  validate_infix_expression(infix_expression)
  expression_elements = infix_expression.gsub(' ', '').scan(/\d+|\S/)
  operator_priorities.keys.each do |priority|
    while (index = expression_elements.find_index { |element| operator_priorities[priority].include? element })
      expression_elements[index - 1] += " #{expression_elements[index + 1]} #{expression_elements[index]}"
      expression_elements.delete_at index + 1
      expression_elements.delete_at index
    end
  end
  expression_elements[0]
end

def validate_infix_expression(string)
  pattern = %r"^\s*\d+(\s*[+\-*/]\s*\d+\s*)*$"
  unless string =~ pattern
    raise NotExpressionError.new "#{string} isn't a valid expression"
  end
end

def main
  print "Please enter your expression: "
  infix_expression = gets.chomp
  puts get_postfix_notation infix_expression
end

main