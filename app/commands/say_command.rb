# frozen_string_literal: true

class SayCommand < BaseCommand
  def run
    with_account do
      with_character do |character|
        with_position do |position|
          session.chat_server.say(character, position.room, argument)
        end
      end
    end
  end
end
