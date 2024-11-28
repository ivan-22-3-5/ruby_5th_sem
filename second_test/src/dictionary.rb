# frozen_string_literal: true

class Dictionary
  attr_reader :data

  def initialize(data = {})
    @data = data
  end

  def +(other)
    Dictionary.new(@data.merge(other.data))
  end

  def to_s
    @data.to_s
  end
end