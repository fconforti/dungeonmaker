# frozen_string_literal: true

class HelpCommand
  include Interactor

  def call
    context.socket.print "Help!\n"
  end
end
