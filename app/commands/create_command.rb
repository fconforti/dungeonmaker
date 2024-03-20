# frozen_string_literal: true

class CreateCommand < BaseCommand
  ARGUMENTS = %w[character dungeon room exit].freeze

  def run
    with_account do
      arg = argument
      return invalid_argument(arg) unless ARGUMENTS.include?(arg)
      send arg
    end
  end

  private

  def character
    model = Character.new
    model.account = session.account
    model.race = select('Choose a race:', Race.all)
    model.klass = select('Choose a class:', Klass.all)
    model.name = ask('Choose a name:')
    model.save ? created_message(model) : error_messages(model)
  end

  def dungeon
    model = Dungeon.new
    model.account = session.account
    model.name = ask('Choose a name:')
    model.save ? created_message(model) : error_messages(model)
  end

  def room
    model = Room.new
    model.account = session.account
    model.dungeon = select('Choose a dungeon:', session.account.dungeons)
    model.name = ask('Choose a name:')
    model.description = ask('Description:')
    model.save ? created_message(model) : error_messages(model)
  end

  def exit
    model = Exit.new
    model.account = session.account
    model.dungeon = select('Choose a dungeon:', session.account.dungeons)
    model.from_room = select('From room:', session.account.rooms)
    model.to_room = select('To room:', session.account.rooms)
    model.save ? created_message(model) : error_messages(model)
  end
end
