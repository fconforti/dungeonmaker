# frozen_string_literal: true

class PassCommand < BaseCommand
  before :require_account!
  before :require_character!
  before :require_position!

  def call
    position = context.session.character.position
    if obstacle = position.room.obstacles.find_by(name: context.argument)
      unless context.session.character.pass!(obstacle)
        context.fail!(message: "You can't pass: #{obstacle.name}") 
      end
    else
      invalid_argument! context.argument
    end
  end
end
