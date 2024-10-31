require 'thor'
require 'rainbow/refinement'

require_relative '../todos'
require_relative '../utils'

using Rainbow

class TodosApp < Thor
  desc "list", "lists todos"

  method_option :completed, type: :boolean, default: nil, aliases: :c
  method_option :days, type: :numeric, default: nil, aliases: :d
  method_option :expired, type: :boolean, default: nil, aliases: [:e, "--exp"]

  def list
    todos = Todos.all

    query = [
      options[:completed].nil? || proc { |todo| todo['completed'] == options[:completed] },
      options[:expired].nil? || proc { |todo| !todo['deadline'].nil? && ((DateTime.parse(todo['deadline']) - DateTime.now) <= 0) == options[:expired] },
      options[:days].nil? || proc { |todo| (DateTime.parse(todo['deadline']) - DateTime.now) <= options[:days] }
    ].reject { |q| q == true }

    puts Utils.build_table(todos.select { |todo| query.all? { |q| q.call(todo) } }) unless todos.empty?
    puts "No todos found".blue if todos.empty?
  end
end