require 'thor'
require 'rainbow/refinement'

require_relative '../todos'
require_relative '../utils'

using Rainbow
class TodosApp < Thor
  desc "show", "shows todos"
  def show
    todos = Todos.all
    puts "No todos found".blue if todos.empty?
    puts Utils.build_table(todos) unless todos.empty?
  end
end