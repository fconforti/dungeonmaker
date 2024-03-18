# frozen_string_literal: true

class ListCommand < BaseCommand
  ARGUMENTS = %w[characters dungeons].freeze

  EMPTY_LIST = 'Empty.'

  def run
    if session.account
      arg = argument
      return invalid_argument(arg) unless ARGUMENTS.include?(arg)

      collection = session.account.send(arg)
      if collection.empty?
        warning EMPTY_LIST
      else
        list_collection session.account.send(arg)
      end
    else
      warning ACCOUNT_REQUIRED
    end
  end
end
