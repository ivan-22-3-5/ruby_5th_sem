# frozen_string_literal: true
require_relative '../src/order'
require_relative '../src/product'

RSpec.describe Order do
  let(:product1) { Product.new("Laptop", 999.99) }
  let(:product2) { Product.new("Phone", 499.99) }

  describe '#initialize' do
    it 'initializes with an empty products array if no products are provided' do
      order = Order.new
      expect(order.instance_variable_get(:@products)).to eq([])
    end

    it 'initializes with provided products' do
      order = Order.new([product1])
      expect(order.instance_variable_get(:@products)).to eq([product1])
    end
  end

  describe '#add' do
    it 'adds a product to the products array' do
      order = Order.new
      order.add(product1)
      expect(order.instance_variable_get(:@products)).to include(product1)
    end

    it 'allows method chaining' do
      order = Order.new
      result = order.add(product1).add(product2)
      expect(result).to be_an(Order)
    end
  end

  describe '#total' do
    it 'returns 0 when there are no products' do
      order = Order.new
      expect(order.total).to eq(0)
    end

    it 'returns the sum of all product prices' do
      order = Order.new([product1, product2])
      expect(order.total).to eq(1499.98)
    end
  end
end