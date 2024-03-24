# frozen_string_literal: true

class GoCommand < BaseCommand
  ROOM_REQUIRED = 'This dungeon doesn\'t have any room.'

  def run
    return invalid_argument(argument) unless Exit::DIRECTIONS.include?(argument)
    with_account do
      with_character do
        with_position do |position|
          if (exit = position.room.exits.find_by(direction: argument))
            position.update(room: exit.to_room)
          elsif (entrance = position.room.entrances.find_by(direction: Exit::INVERTED_DIRECTIONS[argument]))
            position.update(room: entrance.from_room)
          else
            warning "There are no exits nor entrances at the #{argument}"
          end
        end
      end
    end
  end
end
