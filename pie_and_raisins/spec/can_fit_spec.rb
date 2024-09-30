# frozen_string_literal: true
require_relative '../src/main'
require_relative '../src/rectangle'

RSpec.describe 'can_fit?' do
  it 'passes test case 1' do
    forms = [Rectangle.new(5, 10), Rectangle.new(5, 10)]
    expect(can_fit?(Rectangle.new(10, 10), forms)).to eq(true)
  end

  it 'passes test case 2' do
    forms = [Rectangle.new(10, 5), Rectangle.new(10, 5)]
    expect(can_fit?(Rectangle.new(10, 10), forms)).to eq(true)
  end

  it 'passes test case 3' do
    forms = [Rectangle.new(10, 5)]
    expect(can_fit?(Rectangle.new(10, 10), forms)).to eq(false)
  end

  it 'passes test case 4' do
    forms = [Rectangle.new(10, 5), Rectangle.new(10, 5), Rectangle.new(10, 5)]
    expect(can_fit?(Rectangle.new(10, 10), forms)).to eq(false)
  end

  it 'passes test case 5' do
    forms = [Rectangle.new(1, 1),
             Rectangle.new(1, 1),
             Rectangle.new(2, 1),
    ]
    expect(can_fit?(Rectangle.new(2, 2), forms)).to eq(true)
  end

  it 'passes test case 6' do
    forms = [Rectangle.new(1, 1),
             Rectangle.new(3, 1),

             Rectangle.new(2, 2),
             Rectangle.new(1, 1),
             Rectangle.new(1, 1),
             Rectangle.new(2, 1),

             Rectangle.new(4, 1),
             Rectangle.new(4, 2),
    ]
    expect(can_fit?(Rectangle.new(4, 6), forms)).to eq(true)
  end

  it 'passes test case 7' do
    forms = [Rectangle.new(2, 6),
             Rectangle.new(6, 2),
             Rectangle.new(6, 2),
             Rectangle.new(6, 2),
    ]
    expect(can_fit?(Rectangle.new(8, 6), forms)).to eq(true)
  end
end