# frozen_string_literal: true
require 'rspec'
require_relative '../src/main'

RSpec.describe 'cut_pie' do
  it 'passes test case 1' do
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

  it 'passes test case 2' do
    pie = [
      [
        [0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0, 0, 0]
      ]
    ]
    slices = [
      [[0, 1, 0, 0, 0, 0, 0]],
      [[0, 0, 0, 0, 0, 0, 1]],
      [[0, 0, 0, 0, 1, 0, 0]],
      [[0, 0, 1, 0, 0, 0, 0]],
    ]

    expect(cut_pie(pie)).to eq(slices)
  end

  it 'passes test case 3' do
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