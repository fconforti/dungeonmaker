# frozen_string_literal: true

class QuitCommand < BaseCommand
  def run
    session.socket.puts 'Goodbye!'.colorize(:light_blue)
    session.socket.close
  end
end
