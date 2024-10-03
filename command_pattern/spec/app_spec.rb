# frozen_string_literal: true

require 'rspec'
require_relative '../src/application'

RSpec.describe Application do
  let(:application) { Application.new }

  describe '#append_text' do
    it 'appends text to the editor' do
      application.text_field = "Hello"
      application.append_text

      expect(application.editor.text).to eq("Hello")
    end
  end

  describe '#backspace' do
    it 'removes text from the editor' do
      application.text_field = "Hello"
      application.append_text
      application.backspace
      application.backspace

      expect(application.editor.text).to eq("Hel")
    end
  end

  describe '#undo' do
    it 'undoes the last command from history' do
      application.text_field = "Test"
      application.append_text
      expect(application.editor.text).to eq("Test")
      application.undo
      expect(application.editor.text).to eq("")
    end
  end
end
