# frozen_string_literal: true

require_relative 'commands'
require_relative 'text_editor'
require_relative 'button'
include Commands

class Application
  attr_accessor :text_field, :editor
  def initialize
    @text_field = ""
    @editor = TextEditor.new
    @append_button = Button.new
    @backspace_button = Button.new
    @history = []
  end

  def append_text
    command = AppendCommand.new(@editor, @text_field)
    @text_field = ""
    @append_button.command = command
    @append_button.click
    @history << command
  end

  def backspace
    command = RemoveCommand.new(@editor, 1)
    @backspace_button.command = command
    @backspace_button.click
    @history << command
  end

  def undo
    last_command = @history.pop
    last_command.undo if last_command
  end

end
