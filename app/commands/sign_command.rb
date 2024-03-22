# frozen_string_literal: true

class SignCommand < BaseCommand
  ARGUMENTS = %w[up in out].freeze

  SIGNED_UP = "Account created. You're now signed in."
  SIGNED_IN = "Welcome back! You're now signed in."
  SIGNED_OUT = "You're now signed out."

  INVALID_EMAIL_OR_PASSWORD = 'Invalid email or password.'

  def run
    return invalid_argument(argument) unless ARGUMENTS.include?(argument)

    send argument
  end

  private

  def up
    with_no_account do
      email = ask('Enter your email:')
      account = Account.new(email:)
      account.password = ask('Choose a password:')
      account.password_confirmation = ask('Confirm password:')
      if account.save
        success SIGNED_UP
        session.account = account
      else
        error_messages(account)
      end
    end
  end

  def in
    with_no_account do
      email = ask('Enter your email:')
      password = ask('Enter your password:')
      account = Account.find_by(email:)
      if account&.authenticate(password)
        success SIGNED_IN
        session.account = account
      else
        error INVALID_EMAIL_OR_PASSWORD
      end
    end
  end

  def out
    with_account do
      session.account = nil
      success SIGNED_OUT
    end
  end
end
