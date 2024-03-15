# frozen_string_literal: true
module Commands
  class Create
    include Interactor
    include Inputs
    include Outputs

    ARGUMENTS = %w[character dungeon].freeze

    def call
      arg = context.argument
      return invalid_argument(arg) unless ARGUMENTS.include?(arg)

      send arg
    end

    private

    def character
      model = Character.new
      model.account = context.account
      model.race = select('Choose a race:', Race.all)
      model.klass = select('Choose a class:', Klass.all)
      model.name = ask('Choose a name:')
      model.save ? created_message(model) : error_messages(model)
    end

    def dungeon
      model = Dungeon.new
      model.account = context.account
      model.name = ask('Choose a name:')
      model.save ? created_message(model) : error_messages(model)
    end
  end
end