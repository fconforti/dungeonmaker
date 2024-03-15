# frozen_string_literal: true

class SigninCommand < BaseCommand

  def call
    unless context.account
      email = ask("Enter your email:")
      if account = Account.find_by(email:)
        password = ask("Enter your password:")
        if account.authenticate(password)
          context.socket.puts "Thank you! You're now logged in.".colorize(:green)
          context.account = account
        else
          context.socket.puts 'Invalid password'.colorize(:red)
        end
      else
        context.socket.puts 'Email not found. Type "signup" to create an account.'.colorize(:red)
      end
    else
      already_logged_in
    end
  end
end