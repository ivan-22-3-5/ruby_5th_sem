# frozen_string_literal: true

class Button
  attr_accessor :command
  def initialize(command=nil)
    @command = command
  end

  def click
    @command.execute if @command
  end
end
