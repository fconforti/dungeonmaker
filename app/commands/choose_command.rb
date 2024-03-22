# frozen_string_literal: true

class ChooseCommand < BaseCommand
  def run
    with_account do
      if (character = session.account.characters.find_by(name: argument))
        session.character = character
        success "You are now playing as #{session.character.name}."
      else
        invalid_argument(argument)
      end
    end
  end
end
