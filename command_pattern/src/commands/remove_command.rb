# frozen_string_literal: true

require_relative 'command'

class RemoveCommand < Command
  def initialize(editor, qty)
    @editor = editor
    @qty = qty
    @backup = @editor.text
  end

  def execute
    @backup = @editor.remove_text(@qty)
  end

  def undo
    @editor.add_text(@backup)
  end
end
