# frozen_string_literal: true

class QuitCommand < BaseCommand
  def run
    session.socket.puts 'Goodbye!'.colorize(:magenta)
    session.socket.close
  end
end
