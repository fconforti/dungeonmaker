# frozen_string_literal: true

class ListCommand < BaseCommand
  ARGUMENTS = %w[characters dungeons].freeze

  EMPTY_LIST = 'Empty.'

  def call
    if context.account
      arg = context.argument
      return invalid_argument(arg) unless ARGUMENTS.include?(arg)

      collection = context.account.send(arg)
      if collection.empty?
        warning EMPTY_LIST
      else
        list_collection context.account.send(arg)
      end
    else
      warning ACCOUNT_REQUIRED
    end
  end
end
