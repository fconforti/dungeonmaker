# frozen_string_literal: true

class CreateCommand < BaseCommand
  ARGUMENTS = %w[character dungeon room exit].freeze

  def run
    arg = argument
    return invalid_argument(arg) unless ARGUMENTS.include?(arg)
    send arg
  end

  private

  def character
    account_required!    
    model = Character.new
    model.account = session.account
    model.race = select('Choose a race:', Race.all)
    model.klass = select('Choose a class:', Klass.all)
    model.name = ask('Choose a name:')
    model.save ? created_message(model) : error_messages(model)
  end

  def dungeon
    account_required!    
    model = Dungeon.new
    model.account = session.account
    model.name = ask('Choose a name:')
    model.save ? created_message(model) : error_messages(model)
  end

  def room
    account_required!
    dungeon_required!
    model = Room.new
    model.account = session.account
    model.dungeon = session.dungeon
    model.name = ask('Choose a name:')
    model.description = ask('Description:')    
    model.save ? created_message(model) : error_messages(model)
  end

  def exit
    account_required!
    dungeon_required!    
    model = Exit.new
    model.account = session.account
    model.dungeon = session.dungeon
    model.room_a = select('Room A:', session.dungeon.rooms)
    model.room_b = select('Room B:', session.dungeon.rooms)
    model.save ? created_message(model) : error_messages(model)
  end 
end
