# frozen_string_literal: true

module Inputs
  extend ActiveSupport::Concern

  included do
    def select(prompt, collection)
      print_prompt(prompt)
      options_for_select(collection)
      print_cursor
      collection[user_input.to_i - 1]
    end

    def ask(prompt)
      print_prompt(prompt)
      print_cursor
      user_input
    end

    private

    def print_prompt(prompt)
      context.socket.puts prompt.colorize(:light_blue)
    end

    def print_cursor
      context.socket.print '> '
    end

    def user_input
      context.socket.gets.chomp
    end

    def options_for_select(collection)
      collection.each_with_index do |model, index|
        context.socket.print "[#{index + 1}] ".colorize(:light_blue)
        context.socket.puts model.name
      end
    end
  end
end
