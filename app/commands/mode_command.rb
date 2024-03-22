# frozen_string_literal: true

class ModeCommand < BaseCommand
  ARGUMENTS = %w[play edit].freeze

  def run
    return invalid_argument(argument) unless ARGUMENTS.include?(argument)

    session.mode = argument
    success "Game mode changed: #{session.mode}"
  end
end
