# frozen_string_literal: true

class ChooseCommand < BaseCommand

  before :require_account!

  def call
    if (character = context.session.account.characters.find_by(name: context.argument))
      context.session.character = character
      success "You are now playing as #{character.name}."
    else
      invalid_argument!(context.argument)
    end
  end
end
