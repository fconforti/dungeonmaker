# frozen_string_literal: true

class SignupCommand
  include Interactor
  include Inputs
  include Outputs

  def call
    model = User.new
    model.name = ask('Choose a name:')
    model.password = ask('Choose a password:')
    model.password_confirmation = ask('Confirm password:')
    model.save ? created_message(model) : error_messages(model)
  end
end
