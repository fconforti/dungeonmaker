# frozen_string_literal: true

class HelpCommand
  include Interactor

  def call
    context.socket.puts "Help! (#{context.argument})".colorize(:green)
  end
end
