# frozen_string_literal: true

class SignupCommand < BaseCommand
  
  def call
    unless context.account
      email = ask("Enter your email:")
      account = Account.new(email:)
      account.password = ask('Choose a password:')
      account.password_confirmation = ask('Confirm password:')
      if account.save
        context.socket.puts "Thank you! You're now logged in.".colorize(:green)
        context.account = account
      else
        error_messages(account)
      end
    else
      already_logged_in
    end
  end
end