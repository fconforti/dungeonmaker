# frozen_string_literal: true

class QuitCommand
  include Interactor

  def call
    context.socket.print 'Goodbye!'.colorize(:light_blue)
    context.socket.close
  end
end
