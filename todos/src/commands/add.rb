require 'thor'
require 'json'
require 'date'
require 'rainbow/refinement'

require_relative '../utils'
require_relative '../todos'
using Rainbow

class TodosApp < Thor
  desc "add TITLE", "Creates todo with the given title"
  method_option :date, type: :string, default: nil, aliases: :d
  method_option :time, type: :string, default: nil, aliases: :t

  def add(title)
    begin
      date = options[:date] ? Utils.parse_datetime(options[:date],  '%d.%m.%y', '%d.%m') : DateTime.now
      time = options[:time] ? Utils.parse_datetime(options[:time], '%H:%M') : DateTime.new(0)
      deadline = DateTime.new(date.year, date.month, date.day, time.hour, time.min)

      Todos.add({ 'title' => title, 'completed' => false, 'deadline' => deadline })
      puts "Added todo '#{title}' with deadline #{deadline.strftime('%d.%m.%y %H:%M')}".green

    rescue Date::Error
      puts "[ERROR]: Invalid datetime format. Use 'dd.mm' or 'dd.mm.yy' for date and 'hh:mm' for time.".red
    rescue Todos::AlreadyExistsError
      puts "[ERROR]: Todo with the title #{title} already exists".red
    end
  end
end