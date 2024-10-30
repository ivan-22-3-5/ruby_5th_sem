require 'thor'
require 'rainbow/refinement'

require_relative '../todos'
require_relative '../utils'

using Rainbow

class TodosApp < Thor
  desc "remove TITLE", "removes todo with the given title"

  def remove(title)
    begin
      Todos.remove(title)
      puts "Removed todo '#{title}'".green
    rescue Todos::DoesNotExistError
      puts "[ERROR]: Todo with the title #{title} does not exist".red
    end
  end
end