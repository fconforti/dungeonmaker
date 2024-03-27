# frozen_string_literal: true

class SignCommand < BaseCommand  
  ARGUMENTS = %[up in out].freeze

  SIGNED_UP = "Account created. You're now signed in."
  SIGNED_IN = "Welcome back! You're now signed in."
  SIGNED_OUT = "You're now signed out."

  INVALID_EMAIL_OR_PASSWORD = 'Invalid email or password.'

  before :validate_argument!

  def call
    send context.argument
  end

  private

  def up
    require_no_account!
    email = ask('Enter your email:')
    account = Account.new(email:)
    account.password = ask('Choose a password:')
    account.password_confirmation = ask('Confirm password:')
    if account.save
      success SIGNED_UP
      context.session.account = account
    else
      error_messages(account)
    end
  end

  def in
    require_no_account!
    email = ask('Enter your email:')
    password = ask('Enter your password:')
    account = Account.find_by(email:)
    if account&.authenticate(password)
      success SIGNED_IN
      context.session.account = account
    else
      error INVALID_EMAIL_OR_PASSWORD
    end
  end

  def out
    require_account!
    context.session.account = nil
    success SIGNED_OUT
  end
end
