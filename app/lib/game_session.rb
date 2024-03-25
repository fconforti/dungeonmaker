# frozen_string_literal: true

class GameSession
  attr_accessor :socket, :chat_server, :account, :character, :mode

  def initialize(socket, chat_server = nil)
    @socket = socket
    @chat_server = chat_server
  end

  def play
    welcome_user
    add_to_chat
    prompt_command
  end

  private

  def welcome_user
    font = TTY::Font.new(:doom)
    socket.puts font.write('DUNGEON MAKER').colorize(:green)
  end

  def add_to_chat
    chat_server.add_session(self)
  end

  def prompt_command
    loop do
      socket.puts
      socket.print '> '
      input = socket.gets.chomp
      command_name, argument = input.split
      # begin
      command = Object.const_get("#{command_name.classify}Command")
      command.new(argument, self).run
      break if socket.closed?
      # rescue NameError
      #   socket.puts "Please check your input. Type 'help' for the command reference.".colorize(:red)
      # end
    end
  end
end
