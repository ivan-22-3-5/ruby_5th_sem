module Todos
  AlreadyExistsError = Class.new(StandardError)
  DoesNotExistError = Class.new(StandardError)
  AlreadyCompletedError = Class.new(StandardError)

  FILENAME = 'todos.json'
  class << self
    def add(todo)
      todos = read_todos

      if todos.any? { |t| t['title'] == todo['title'] }
        raise AlreadyExistsError, "Todo with the title #{todo['title']} already exists"
      end

      write_todos(todos + [todo])
    end

    def complete(title)
      todos = read_todos
      todo_to_complete = todos.find { |todo| todo['title'] == title }
      raise DoesNotExistError, "Todo with the title #{title} does not exist" if todo_to_complete.nil?
      raise AlreadyCompletedError, "Todo with the title #{title} is already completed" if todo_to_complete['completed']
      todo_to_complete['completed'] = true
      write_todos(todos)
    end

    def read_todos
      json_string = File.read(FILENAME) rescue '[]'
      JSON.parse(json_string)
    end

    def write_todos(todos)
      File.open(FILENAME, 'w') do |f|
        JSON.dump(todos, f)
      end
    end

    alias_method :all, :read_todos
    private :read_todos, :write_todos
  end
end