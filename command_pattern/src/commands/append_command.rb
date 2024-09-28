# frozen_string_literal: true

require_relative 'command'

class AppendCommand < Command
  def initialize(editor, text)
    @editor = editor
    @text = text
  end

  def execute
    @editor.add_text(@text)
  end

  def undo
    @editor.remove_text(@text.length)
  end
end
