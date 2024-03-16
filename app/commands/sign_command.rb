# frozen_string_literal: true

class SignCommand < BaseCommand

  ARGUMENTS = %w[up in out].freeze
  
  SIGNED_UP = "Account created. You're now signed in."
  SIGNED_IN = "Welcome back! You're now signed in."
  SIGNED_OUT = "You're now signed out."

  ALREADY_SIGNED_IN = "You're already signed in."
  ALREADY_SIGNED_OUT = "You're already signed out."

  INVALID_EMAIL_OR_PASSWORD = "Invalid email or password."

  def call
    arg = context.argument
    return invalid_argument(arg) unless ARGUMENTS.include?(arg)
    send arg
  end

  private
  def up
    unless context.account
      email = ask("Enter your email:")
      account = Account.new(email:)
      account.password = ask('Choose a password:')
      account.password_confirmation = ask('Confirm password:')
      if account.save
        success SIGNED_UP
        context.account = account
      else
        error_messages(account)
      end
    else
      warning ALREADY_SIGNED_IN
    end
  end

  def in
    unless context.account
      email = ask("Enter your email:")
      password = ask("Enter your password:")
      account = Account.find_by(email:)
      if account && account.authenticate(password)
        success SIGNED_IN
        context.account = account
      else
        error INVALID_EMAIL_OR_PASSWORD
      end
    else
      warning ALREADY_SIGNED_IN
    end
  end

  def out
    if context.account
      context.account = nil
      success SIGNED_OUT
    else
      warning ALREADY_SIGNED_OUT
    end
  end

end