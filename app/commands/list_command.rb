# frozen_string_literal: true

class ListCommand < BaseCommand
  ARGUMENTS = %w[characters dungeons rooms exits].freeze

  EMPTY_LIST = 'Empty.'

  before :validate_argument!
  before :require_account!

  def call
    collection = context.session.account.send(context.argument)
    if collection.empty?
      context.fail! message: EMPTY_LIST
    else
      list_collection context.session.account.send(context.argument)
    end
  end
end
