# frozen_string_literal: true
require 'rspec'
require_relative '../src/main.rb'

RSpec.describe 'get_postfix_notation' do
  context 'with simple expressions' do
    it 'converts a simple expression to postfix' do
      expect(get_postfix_notation('3 + 4')).to eq('3 4 +')
      expect(get_postfix_notation('10 - 5')).to eq('10 5 -')
      expect(get_postfix_notation('2 * 3')).to eq('2 3 *')
      expect(get_postfix_notation('8 / 2')).to eq('8 2 /')
    end
  end

  context 'with multiple operations' do
    it 'handles multiple operators correctly' do
      expect(get_postfix_notation('3 + 4 * 2')).to eq('3 4 2 * +')
      expect(get_postfix_notation('10 - 5 + 2')).to eq('10 5 - 2 +')
    end
  end

  context 'with real numbers' do
    it 'converts a simple expression to postfix' do
      expect(get_postfix_notation('3.5 + 4')).to eq('3.5 4 +')
      expect(get_postfix_notation('-5.5 - 1')).to eq('-5.5 1 -')
      expect(get_postfix_notation('2.77 * 3')).to eq('2.77 3 *')
      expect(get_postfix_notation('8 / 2.43')).to eq('8 2.43 /')
    end
  end

  context 'with negative numbers' do
    it 'handles negative numbers correctly' do
      expect(get_postfix_notation('-3 + 4')).to eq('-3 4 +')
      expect(get_postfix_notation('(2 - -3)')).to eq('2 -3 -')
      expect(get_postfix_notation('5 / (-2 + -3)')).to eq('5 -2 -3 + /')
    end
  end

  context 'with parentheses' do
    it 'handles expressions with parentheses' do
      expect(get_postfix_notation('(1 + 2) * 3')).to eq('1 2 + 3 *')
      expect(get_postfix_notation('(1 + 2) * -3.5 + 2 * (33 + 4)')).to eq('1 2 + -3.5 * 2 33 4 + * +')
      expect(get_postfix_notation('3 + (4 * 2)')).to eq('3 4 2 * +')
      expect(get_postfix_notation('((1 + 2) * 7.3) + 4')).to eq('1 2 + 7.3 * 4 +')
    end

    it 'handles nested parentheses' do
      expect(get_postfix_notation('(1 + (2 * 3))')).to eq('1 2 3 * +')
      expect(get_postfix_notation('((-32.43 + 2) * (3 + 4))')).to eq('-32.43 2 + 3 4 + *')
    end
  end

  context 'with invalid expressions' do
    it 'raises NotExpressionError for invalid expressions' do
      expect { get_postfix_notation('THIS IS NOT A VALID EXPRESSION') }.to raise_error(NotExpressionError)
      expect { get_postfix_notation('3 +') }.to raise_error(NotExpressionError)
      expect { get_postfix_notation('+ +') }.to raise_error(NotExpressionError)
      expect { get_postfix_notation('-32.43 + +') }.to raise_error(NotExpressionError)
      expect { get_postfix_notation('+ 3 + 343 -') }.to raise_error(NotExpressionError)
    end
    it 'raises ParenthesesError for invalid parentheses use' do
      expect { get_postfix_notation('(3 + 2') }.to raise_error(ParenthesesError)
      expect { get_postfix_notation(')3 + 2(') }.to raise_error(ParenthesesError)
      expect { get_postfix_notation('(3 + 2()') }.to raise_error(ParenthesesError)
      expect { get_postfix_notation('(3 + 2) + (43-45))') }.to raise_error(ParenthesesError)
    end
  end
end

