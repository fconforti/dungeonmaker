# frozen_string_literal: true

class QuitCommand < BaseCommand
  def call
    context.socket.puts 'Goodbye!'.colorize(:light_blue)
    context.socket.close
  end
end
