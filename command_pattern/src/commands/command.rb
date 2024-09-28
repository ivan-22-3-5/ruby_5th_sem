# frozen_string_literal: true

class Command
  def initialize
    raise NotImplementedError.new "Abstract class cannot be instantiated"
  end

  def execute
    raise NotImplementedError.new "Method 'execute' must be implemented"
  end

  def undo
    raise NotImplementedError.new "Method 'undo' must be implemented"
  end
end
