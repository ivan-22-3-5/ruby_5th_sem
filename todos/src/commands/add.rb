require 'thor'
require 'json'
require 'date'
require 'rainbow/refinement'

require_relative '../utils'
require_relative '../todos'
using Rainbow

class TodosApp < Thor
  desc "add [TITLE]", "Creates todo with the given title"
  method_option :deadline, type: :string, default: nil, aliases: :d

  def add(title)
    begin
      deadline = options[:deadline] && Utils.parse_datetime(options[:deadline],
                                                            '%d.%m.%y-%H:%M', '%d.%m-%H:%M', '%d.%m.%y', '%d.%m', '%H:%M')
      Todos.add(title, deadline)
      date, time = deadline.strftime('%d.%m.%y %H:%M').split(' ') if deadline
      puts "Added todo '#{title}' with #{deadline.nil? ? 'no deadline' : "a deadline at #{time} on #{date}"}".green

    rescue Date::Error
      puts "[ERROR]: Invalid datetime format.\n" \
      "[HINT]: Use 'dd.mm' or 'dd.mm.yy' for date and 'hh:mm' for time.\n" \
      "[HINT]: Separate date and time with '-' example: '01.01-12:00".red
    rescue Todos::AlreadyExistsError
      puts "[ERROR]: Todo with the title #{title} already exists".red
    end
  end
end