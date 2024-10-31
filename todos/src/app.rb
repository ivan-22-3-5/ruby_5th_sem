require_relative 'commands/add'
require_relative 'commands/list'
require_relative 'commands/complete'
require_relative 'commands/remove'
require_relative 'commands/clear'

class TodosApp < Thor
  def self.exit_on_failure?
    false
  end
end