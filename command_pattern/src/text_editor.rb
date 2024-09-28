# frozen_string_literal: true

class TextEditor
  attr_reader :text
  def initialize
    @text = ""
  end

  def add_text(text)
    @text += text
  end

  def remove_text(qty)
    clipped_text = @text[-qty..-1]
    @text = @text[0..-qty-1]
    clipped_text
  end

  def clear_text
    @text = ""
  end
end
