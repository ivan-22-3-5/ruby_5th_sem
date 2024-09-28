# frozen_string_literal: true

require_relative 'command'

class ClearCommand
  def initialize(editor)
    @editor = editor
    @backup = nil
  end

  def execute
    @backup = @editor.text
    @editor.clear_text
  end

  def undo
    @editor.text = @backup
  end
end
