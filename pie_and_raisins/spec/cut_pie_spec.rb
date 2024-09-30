# frozen_string_literal: true
require 'rspec'
require_relative '../src/main'

RSpec.describe 'cut_pie' do
  context  "when array is valid" do
    it 'passes test case 1' do
      pie = [
        [0, 1],
        [1, 0],
      ]

      slices = [
        [[0, 1]],
        [[1, 0]],
      ]

      expect(cut_pie(pie)).to eq(slices)
    end

    it 'passes test case 2' do
      pie = [
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0]
      ]
      slices = [
        [[0, 0, 0, 0, 0, 0, 0],
         [0, 0, 1, 0, 0, 0, 0]],

        [[0, 0, 0, 1, 0, 0, 0],
         [0, 0, 0, 0, 0, 0, 0]],
      ]

      expect(cut_pie(pie)).to eq(slices)
    end

    it 'passes test case 3' do
      pie = [
        [
          [0, 1, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 1],
          [0, 0, 0, 0, 1, 0, 0],
          [0, 0, 1, 0, 0, 0, 0]
        ]
      ]
      slices = [
        [[[0, 1, 0, 0, 0, 0, 0]]],
        [[[0, 0, 0, 0, 0, 0, 1]]],
        [[[0, 0, 0, 0, 1, 0, 0]]],
        [[[0, 0, 1, 0, 0, 0, 0]]],
      ]

      expect(cut_pie(pie)).to eq(slices)
    end

    it 'passes test case 4' do
      pie = [
        [0, 1, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
      ]

      slices = [
        [[0, 1],
         [0, 0],
         [0, 0],
         [0, 0],
         [0, 0],
         [0, 0]],
        [[0, 1, 0, 0, 0, 0],
         [0, 0, 0, 0, 0, 0]],
        [[0, 0, 1, 0, 0, 0],
         [0, 0, 0, 0, 0, 0]],
        [[0, 0, 0, 1, 0, 0],
         [0, 0, 0, 0, 0, 0]]
      ]

      expect(cut_pie(pie)).to eq(slices)
    end
  end

  context  "when array is invalid" do
    it 'raises error when the pie is an empty array' do
      pie = [

      ]
      expect { cut_pie(pie) }.to raise_error 'Array is not valid'
    end

    it 'raises error when the pie is a nested empty array' do
      pie = [
        []
      ]
      expect { cut_pie(pie) }.to raise_error 'Array is not valid'
    end

    it 'raises error when the pie is a jagged array' do
      pie = [
        [0],
        [0, 1, 1],
      ]
      expect { cut_pie(pie) }.to raise_error 'Pie must be rectangular'
    end

    it 'raises error when the pie does not have at least two raisins' do
      pie = [
        [0, 0, 0],
        [0, 0, 1],
      ]
      expect { cut_pie(pie) }.to raise_error 'Pie must have at least two raisins and at most nine raisins'
    end

    it 'raises error when the pie has more than nine raisins' do
      pie = [
        [1, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 1, 1, 0, 0, 0, 0],
      ]

      expect { cut_pie(pie) }.to raise_error 'Pie must have at least two raisins and at most nine raisins'
    end

    it 'raises error when the pie cannot be cut into equal pieces' do
      pie = [
        [1, 1, 0, 0, 1],
        [0, 0, 1, 0, 0],
      ]

      expect { cut_pie(pie) }.to raise_error 'Cutting into equal pieces is not possible'
    end
  end
end