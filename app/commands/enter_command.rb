# frozen_string_literal: true

class EnterCommand < BaseCommand
  ROOM_REQUIRED = 'This dungeon doesn\'t have any room.'

  def run
    with_account do
      with_character do
        with_no_position do
          if (dungeon = Dungeon.find_by(name: argument))
            if (room = dungeon.base_room)
              session.character.create_position(
                account: session.account,
                character: session.character,
                dungeon:,
                room:
              )
              success "You have entered the #{dungeon.name} dungeon. Good luck!"
            else
              warning ROOM_REQUIRED
            end
          else
            invalid_argument(argument)
          end
        end
      end
    end
  end
end
