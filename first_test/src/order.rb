# frozen_string_literal: true

class Order
  def initialize(products=nil)
    @products = products || []
  end

  def add(product)
    @products << product
    self
  end

  def total
    @products.sum(&:price)
  end
end
