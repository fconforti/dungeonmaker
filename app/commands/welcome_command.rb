# frozen_string_literal: true

class WelcomeCommand
  include Interactor
  include Inputs
  include Outputs

  def call
    context.socket.puts "Welcome to Dungeomn Maker!"
    while !context.account.present?
      email = ask("What's your account email?")
      if account = Account.find_by_email(email)
        password = ask("Enter your password for #{email}")
        if account.authenticate(password)
          context.socket.puts "Thank you! You're now logged in.".colorize(:green)
          context.account = account
        else
          context.socket.puts "Invalid password".colorize(:red)
        end
      else
        account = Account.new(email: email)
        account.password = ask('Choose a password:')
        account.password_confirmation = ask('Confirm password:')
        if account.save
          context.socket.puts "Thank you! You're now logged in.".colorize(:green)
          context.account = account
        else
          error_messages(account)
        end
      end
    end
  end
end
