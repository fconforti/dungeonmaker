# frozen_string_literal: true

class SignoutCommand < BaseCommand
  
  def call
    if context.account
      context.account = nil
      context.socket.puts "You're now logged out.".colorize(:green)
    else
      already_logged_out
    end
  end
end