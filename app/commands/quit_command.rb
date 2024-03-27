# frozen_string_literal: true

class QuitCommand < BaseCommand
  def call
    context.session.socket.puts 'Goodbye!'.colorize(:light_blue)
    context.session.socket.close
  end
end
