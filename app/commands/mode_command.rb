# frozen_string_literal: true

class ModeCommand < BaseCommand
  ARGUMENTS = %w[play edit].freeze

  before :validate_argument!

  def call
    context.session.mode = context.argument
    success "Game mode changed: #{context.session.mode}"
  end
end
