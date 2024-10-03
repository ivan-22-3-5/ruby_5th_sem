# frozen_string_literal: true

module Commands
  class AppendCommand
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

  class RemoveCommand
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
end
