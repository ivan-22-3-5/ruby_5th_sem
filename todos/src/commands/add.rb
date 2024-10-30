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
      date = options[:date] ? Utils.parse_datetime(options[:date], '%d.%m', '%d.%m.%Y') : DateTime.now
      time = options[:time] ? Utils.parse_datetime(options[:time], '%H:%M') : DateTime.new(0)
      deadline = DateTime.new(date.year, date.month, date.day, time.hour, time.min)
    rescue Date::Error
      puts "[ERROR]: Invalid datetime format. Use 'dd.mm' or 'dd.mm.yyyy' for date and 'hh:mm' for time.".red
      return
    end

    begin
      Todos.add({ 'name' => name, 'completed' => false, 'deadline' => deadline })
      puts "Added todo '#{name}' with deadline #{deadline.strftime('%d.%m.%Y %H:%M')}".green
    rescue Todos::AlreadyExistsError
      puts "[ERROR]: Todo with name #{name} already exists".red
    end
  end
end