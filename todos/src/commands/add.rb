require 'thor'
require 'json'
require 'date'
require 'rainbow/refinement'

require_relative '../utils'
require_relative '../todos'
using Rainbow
class TodosApp < Thor
  desc "add NAME", "Adds todo"
  method_option :date, type: :string, default: nil, aliases: :d
  method_option :time, type: :string, default: nil, aliases: :t

  def add(name)
    begin
      date = date ? parse_datetime(date, '%d.%m', '%d.%m.%Y'): DateTime.now
      time = time ? parse_datetime(time, '%H:%M') : DateTime.new(0)
      deadline =  DateTime.new(date.year, date.month, date.day, time.hour, time.min)
    rescue Date::Error
      puts "[ERROR]: Invalid datetime format. Use 'dd.mm' or 'dd.mm.yyyy' for date and 'hh:mm' for time.".red
      return
    end
    Todos.add({ name: name, completed: false, deadline: deadline })
  end
end