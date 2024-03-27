# frozen_string_literal: true

class SayCommand < BaseCommand
  before :require_account!
  before :require_character!
  before :require_position!

  def call
    context.session.chat_server.say(context.session.character, context.session.character.position.room, context.argument)
  end
end
