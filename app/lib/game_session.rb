# frozen_string_literal: true

class GameSession
  attr_accessor :socket, :chat_server, :account, :character, :mode

  def initialize(socket, chat_server = nil)
    @socket = socket
    return unless chat_server
    chat_server.add_session(self)
    @chat_server = chat_server
  end

  def play
    welcome_user
    prompt_command
  end

  def welcome_user
    font = TTY::Font.new(:doom)
    socket.puts font.write('DUNGEON MAKER').colorize(:green)
  end

  def prompt_command
    loop do
      input = socket.gets.chomp
      name = input.split[0]
      argument = input.split[1..].join(' ')
      # begin
      call_command(name, argument)

      if socket.closed?
        chat_server.remove_session(self)
        break
      end
      # rescue NameError
      #   socket.puts "Please check your input. Type 'help' for the command reference.".colorize(:red)
      # end
    end
  end

  def call_command(name, argument)
    context = Object.const_get("#{name.classify}Command").call(argument:, session: self)
    socket.puts context.message.colorize(:red) if context.failure?
  end
end
