# frozen_string_literal: true

module Commands
  class Quit
    include Interactor

    def call
      context.socket.puts 'Goodbye!'.colorize(:light_blue)
      context.socket.close
    end
  end
end