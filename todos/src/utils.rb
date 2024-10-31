# frozen_string_literal: true
require 'date'
require 'terminal-table'
require 'rainbow/refinement'

using Rainbow

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
                               build_deadline_string(todo['deadline']),
                               todo['completed'] ? 'yes'.green : 'no'.red] }
    table = Terminal::Table.new :title => "todos", :headings => %w[title deadline completed], :rows => rows
    table.style = { :border => :unicode_thick_edge }
    table
  end

  private_class_method def self.build_deadline_string(deadline)
    return 'no deadline'.green if deadline.nil?

    datetime = DateTime.parse(deadline)
    formatted_deadline = datetime.strftime('%d.%m.%Y %H:%M')
    datetime > DateTime.now ? formatted_deadline.green : formatted_deadline.red
  end
end
