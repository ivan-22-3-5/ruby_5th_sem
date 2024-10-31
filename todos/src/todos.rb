require 'pathname'
require 'json'
module Todos
  AlreadyExistsError = Class.new(StandardError)
  DoesNotExistError = Class.new(StandardError)
  AlreadyCompletedError = Class.new(StandardError)

  FILEPATH = Pathname('files/todos.json')

  class << self
    def add(title, deadline = nil, completed = false)
      todos = read_todos

      if todos.any? { |t| t['title'] == title }
        raise AlreadyExistsError, "Todo with the title #{title} already exists"
      end

      write_todos(todos + [{ 'title' => title, 'deadline' => deadline, 'completed' => completed }])
    end

    def complete(title)
      todos = read_todos
      todo_to_complete = todos.find { |todo| todo['title'] == title }
      raise DoesNotExistError, "Todo with the title #{title} does not exist" if todo_to_complete.nil?
      raise AlreadyCompletedError, "Todo with the title #{title} is already completed" if todo_to_complete['completed']
      todo_to_complete['completed'] = true
      write_todos(todos)
    end

    def remove(title)
      todos = read_todos
      todo_to_delete = todos.find { |todo| todo['title'] == title }
      raise DoesNotExistError, "Todo with the title #{title} does not exist" if todo_to_delete.nil?
      todos.delete(todo_to_delete)
      write_todos(todos)
    end

    def clear(titles)
      todos = read_todos.reject { |todo| titles.include?(todo['title']) }
      write_todos(todos)
    end

    def read_todos
      json_string = File.read(FILEPATH) rescue '[]'
      JSON.parse(json_string)
    end

    def write_todos(todos)
      Dir.mkdir(FILEPATH.parent) unless FILEPATH.parent.exist?
      File.open(FILEPATH, 'w') do |f|
        JSON.dump(todos, f)
      end
    end

    alias_method :all, :read_todos
    private :read_todos, :write_todos
  end
end