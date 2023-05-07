# frozen_string_literal: true

class CreateCommand
  include Interactor
  include Inputs
  include Outputs

  def call
    case context.argument
    when 'character'
      character = Character.new
      character.race = select('Choose a race:', Race.all)
      character.klass = select('Choose a class:', Klass.all)
      character.name = ask('Choose a name:')
      character.save ? created_message(character) : error_messages(character)
    end
  end
end
