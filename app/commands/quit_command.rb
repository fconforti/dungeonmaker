# frozen_string_literal: true

class QuitCommand
  include Interactor

  def call
    context.socket.print "Goodbye!\n"
    context.socket.close
  end
end
