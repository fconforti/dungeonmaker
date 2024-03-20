# frozen_string_literal: true

class ListCommand < BaseCommand
  ARGUMENTS = %w[characters dungeons rooms exits].freeze

  EMPTY_LIST = 'Empty.'

  def run
    with_account do
      arg = argument
      return invalid_argument(arg) unless ARGUMENTS.include?(arg)
      collection = session.account.send(arg)
      if collection.empty?
        warning EMPTY_LIST
      else
        list_collection session.account.send(argument)
      end
    end
  end
end
