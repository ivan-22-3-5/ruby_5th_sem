require 'thor'
require 'rainbow/refinement'

require_relative '../todos'
require_relative '../utils'

using Rainbow

class TodosApp < Thor
  desc "clear", "clears all todos or all that meet the criteria"

  method_option :completed, type: :boolean, default: false, aliases: :c
  method_option :expired, type: :boolean, default: false, aliases: :e

  def clear
    todos = Todos.all
    todos = todos.select { |todo| todo['completed'] } if options[:completed]
    todos = todos.select { |todo| (DateTime.parse(todo['deadline']) - DateTime.now) <= 0 } if options[:expired]

    titles = todos.map { |todo| todo['title'] }
    if titles.empty?
      puts "No todos to remove".blue
      return
    end
    Todos.clear(titles)
    puts "Removed todos: #{titles.join(', ')}".green
  end
end