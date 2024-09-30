# frozen_string_literal: true
require_relative 'application'

def main
  app = Application.new
  app.text_field = "Hello, World!"
  app.append_text
  puts app.editor.text
  app.backspace
  app.backspace
  puts app.editor.text
  app.undo
  app.undo
  puts app.editor.text
end

if __FILE__ == $0
  main
end