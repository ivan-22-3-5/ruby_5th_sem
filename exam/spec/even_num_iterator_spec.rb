# frozen_string_literal: true

require 'rspec'
require_relative '../src/even_num_iterator'

describe EvenNumbersIterator do
  let(:array) { [1, 2, 3, 4, 5, 6] }
  let(:iterator) { EvenNumbersIterator.new(array) }

  describe '#each' do
    it 'returns only even numbers from the array' do
      result = []
      iterator.each { |num| result << num }
      expect(result).to eq([2, 4, 6])
    end

    it 'does not yield any numbers if no even numbers exist' do
      empty_iterator = EvenNumbersIterator.new([1, 3, 5])
      result = []
      empty_iterator.each { |num| result << num }
      expect(result).to be_empty
    end

    it 'works with an empty array' do
      empty_iterator = EvenNumbersIterator.new([])
      result = []
      empty_iterator.each { |num| result << num }
      expect(result).to be_empty
    end

    it 'includes Enumerable methods' do
      expect(iterator.select { |num| num > 3 }).to eq([4, 6])
      expect(iterator.map { |num| num * 2 }).to eq([4, 8, 12])
    end
  end
end