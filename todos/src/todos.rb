module Todos
  AlreadyExistsError = Class.new(StandardError)
  FILENAME = 'todos.json'
  def self.add(todo)
    json_string = File.read(FILENAME) rescue '[]'
    todos = JSON.parse(json_string)

    if todos.any? { |t| t['name'] == todo['name'] }
      raise AlreadyExistsError, "Todo with name #{todo['name']} already exists"
    end

    File.open(FILENAME, 'w') do |f|
      JSON.dump(todos + [todo], f)
    end
  end
end