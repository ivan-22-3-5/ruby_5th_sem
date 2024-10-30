require 'thor'
require 'rainbow/refinement'

require_relative '../todos'
require_relative '../utils'

using Rainbow
class TodosApp < Thor
  desc "complete TITLE", "completes todo with the given title"
  def complete(title)
    begin
      Todos.complete(title)
      puts "Completed todo '#{title}'".green
    rescue Todos::DoesNotExistError
      puts "[ERROR]: Todo with the title #{title} does not exist".red
    rescue Todos::AlreadyCompletedError
      puts "Todo with the title #{title} is already completed".blue
    end
  end
end