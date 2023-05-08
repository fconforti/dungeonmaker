# frozen_string_literal: true

module Outputs
  extend ActiveSupport::Concern

  included do
    def invalid_argument(argument)
      context.socket.puts
      context.socket.puts "Invalid argument: #{argument}".colorize(:red)
    end

    def error_messages(model)
      context.socket.puts
      context.socket.puts 'Ops... something went wrong:'.colorize(:red)
      model.errors.full_messages.each do |error|
        context.socket.puts error.colorize(:red)
      end
    end

    def created_message(model)
      context.socket.puts
      context.socket.puts "Your #{model.class.name.humanize.downcase} has been created!".colorize(:green)
      model.print(context.socket)
    end
  end
end
