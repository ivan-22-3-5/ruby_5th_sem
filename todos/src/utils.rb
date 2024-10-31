# frozen_string_literal: true
require 'date'
require 'terminal-table'

module Utils
  def self.parse_datetime(str, *formats)
    formats.each do |format|
      return DateTime.strptime(str.strip, format)
    rescue Date::Error
      next
    end
    raise Date::Error
  end

  def self.build_table(todos)
    rows = todos.map { |todo| [todo['title'],
                               todo['deadline'].nil? ? '' : DateTime.parse(todo['deadline']).strftime('%d.%m.%Y %H:%M'),
                               todo['completed']] }
    table = Terminal::Table.new :title => "todos", :headings => %w[title deadline completed], :rows => rows
    table.style = { :border => :unicode_thick_edge }
    table
  end
end
