# frozen_string_literal: true

class CreateCommand < BaseCommand
  ARGUMENTS = %w[character dungeon room key exit].freeze

  before :require_account!
  before :validate_argument!

  def call
    send context.argument
  end

  private

  def character
    model = Character.new
    model.account = context.session.account
    model.race = select('Choose a race:', Race.all)
    model.klass = select('Choose a class:', Klass.all)
    model.name = ask('Choose a name:')
    model.save ? created_message(model) : error_messages(model)
  end

  def dungeon
    model = Dungeon.new
    model.account = context.session.account
    model.name = ask('Choose a name:')
    model.save ? created_message(model) : error_messages(model)
  end

  def room
    model = Room.new
    model.account = context.session.account
    model.dungeon = select('Choose a dungeon:', context.session.account.dungeons)
    model.name = ask('Choose a name:')
    model.description = ask('Description:')
    model.save ? created_message(model) : error_messages(model)
  end

  def key
    model = Key.new
    model.account = context.session.account
    model.dungeon = select('Choose a dungeon:', context.session.account.dungeons)
    model.name = ask('Choose a name:')
    model.description = ask('Description:')
    model.save ? created_message(model) : error_messages(model)
  end

  def exit
    model = Exit.new
    model.account = context.session.account
    model.dungeon = select('Choose a dungeon:', context.session.account.dungeons)
    model.from_room = select('From room:', context.session.account.rooms)
    model.to_room = select('To room:', context.session.account.rooms)
    model.direction = ask('Choose a direction:')
    model.key = select('Key:', context.session.account.keys)
    model.save ? created_message(model) : error_messages(model)
  end
end
