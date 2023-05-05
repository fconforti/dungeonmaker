# frozen_string_literal: true

class HelpCommand
  include Interactor

  def call
    context.socket.puts 'Hello!'.colorize(:green)
  end
end
