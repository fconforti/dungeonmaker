# frozen_string_literal: true

module Inputs
  extend ActiveSupport::Concern

  CREATE_NEW_OPTION = 'NEW'

  included do
    def select(prompt, collection, create_new=false)
      print_prompt(prompt)
      options_for_select(collection, create_new)
      print_cursor
      user_input = get_user_input
      return CREATE_NEW_OPTION if user_input == CREATE_NEW_OPTION
      collection[user_input.to_i - 1]
    end

    def ask(prompt)
      print_prompt(prompt)
      print_cursor
      get_user_input
    end

    private

    def print_prompt(prompt)
      context.socket.puts prompt.colorize(:light_blue)
    end

    def print_cursor
      context.socket.print '> '
    end

    def get_user_input
      context.socket.gets.chomp
    end

    def options_for_select(collection, create_new=false)
      collection.each_with_index do |model, index|
        context.socket.print "[#{index + 1}] ".colorize(:light_blue)
        context.socket.puts model.name
      end
      if create_new
        context.socket.print "[#{CREATE_NEW_OPTION}] ".colorize(:light_blue)
        context.socket.puts "Create new..."
      end
    end
  end
end
