# frozen_string_literal: true

class QuitCommand
  include Interactor

  def call
    context.socket.puts 'Goodbye!'.colorize(:light_blue)
    context.socket.close
  end
end
