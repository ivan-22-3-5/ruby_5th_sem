# frozen_string_literal: true

require 'rspec'
require_relative '../src/shapes'

RSpec.describe Shape do
  describe '#initialize' do
    it 'raises NotImplementedError when instantiated directly' do
      expect { Shape.new }.to raise_error(NotImplementedError)
    end
  end

  describe '#area' do
    it 'raises NotImplementedError when called directly' do
      class TestShape < Shape; end
      shape = TestShape.allocate
      expect { shape.area }.to raise_error(NotImplementedError)
    end
  end
end

RSpec.describe Square do
  describe '#initialize' do
    it 'creates a square with the given side length' do
      square = Square.new(5)
      expect(square.instance_variable_get(:@side)).to eq(5)
    end
  end

  describe '#area' do
    it 'calculates the correct area of the square' do
      square = Square.new(5)
      expect(square.area).to eq(25)
    end
  end
end

RSpec.describe Triangle do
  describe '#initialize' do
    it 'creates a triangle with the given base and height' do
      triangle = Triangle.new(3, 4)
      expect(triangle.instance_variable_get(:@base)).to eq(3)
      expect(triangle.instance_variable_get(:@height)).to eq(4)
    end
  end

  describe '#area' do
    it 'calculates the correct area of the triangle' do
      triangle = Triangle.new(3, 4)
      expect(triangle.area).to eq(6)
    end
  end
end
