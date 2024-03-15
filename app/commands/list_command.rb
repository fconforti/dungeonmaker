# frozen_string_literal: true

class ListCommand < BaseCommand

  ARGUMENTS = %w[characters dungeons].freeze

  def call
    if context.account
      arg = context.argument
      return invalid_argument(arg) unless ARGUMENTS.include?(arg)
      collection = context.account.send(arg)
      unless collection.empty?
        list_collection context.account.send(arg)
      else
        empty_collection
      end
    else
      account_required
    end
  end

end