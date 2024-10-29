module Todos
  def self.add(todo)
    json_string = File.read('todos.json') rescue '[]'
    todos = JSON.parse(json_string) << todo

    File.open('todos.json', 'w') do |f|
      JSON.dump(todos, f)
    end
  end
end