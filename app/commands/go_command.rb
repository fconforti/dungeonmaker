# frozen_string_literal: true

class GoCommand < BaseCommand
  ROOM_REQUIRED = 'This dungeon doesn\'t have any room.'
  ARGUMENTS = Exit::DIRECTIONS

  before :validate_argument!
  before :require_account!
  before :require_character!
  before :require_position!

  def call
    position = context.session.character.position
    if (exit = position.room.exits.find_by(direction: context.argument))
      require_no_obstacles!(exit)
      position.update(room: exit.to_room)
    elsif (entrance = position.room.entrances.find_by(direction: Exit::INVERTED_DIRECTIONS[context.argument]))
      require_no_obstacles!(entrance)
      position.update(room: entrance.from_room)
    else
      context.fail! message: "There are no exits nor entrances at the #{context.argument}"
    end
  end

  private
  def require_no_obstacles!(exit)
    obstacles = Obstacle.for_character(context.session.character)
    if obstacles.any?
      context.fail! message: obstacles.map{|o| o.name}.join(", ")
    end
  end
end
