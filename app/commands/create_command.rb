# frozen_string_literal: true

class CreateCommand < BaseCommand
  ARGUMENTS = %w[character dungeon room key exit obstacle].freeze

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
    model.name = ask('Choose a name:')
    model.description = ask('Description:')
    model.save ? created_message(model) : error_messages(model)
  end

  def obstacle
    model = Obstacle.new
    model.account = context.session.account
    model.dungeon = select('Choose a dungeon:', context.session.account.dungeons)
    model.exit = select('Choose an exit:', context.session.account.exits)
    item_type = select('Item type:', Obstacle::ITEM_TYPES)
    model.item = select('Choose an item:', Object.const_get(item_type).where(dungeon_id: model.dungeon_id).all)
    model.name = ask('Choose a name:')
    model.description = ask('Description:')
    model.save ? created_message(model) : error_messages(model)
  end

end
