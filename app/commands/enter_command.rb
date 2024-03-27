# frozen_string_literal: true

class EnterCommand < BaseCommand
  ROOM_REQUIRED = 'This dungeon doesn\'t have any room.'

  before :require_account!
  before :require_character!
  before :require_no_position!

  def call
    if (dungeon = Dungeon.find_by(name: context.argument))
      if (room = dungeon.base_room)
        context.session.character.create_position(
          account: context.session.account,
          character: context.session.character,
          dungeon:,
          room:
        )
        success "You have entered the #{dungeon.name} dungeon. Good luck!"
      else
        context.fail! message: ROOM_REQUIRED
      end
    else
      invalid_argument! context.argument
    end
  end
end
