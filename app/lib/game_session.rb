# frozen_string_literal: true

class GameSession
  attr_accessor :socket, :account, :character, :mode

  def initialize(socket, account = nil, character = nil, mode = :play)
    @socket = socket
    @account = account
    @character = character
    @mode = mode
  end

  def play
    welcome_user
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

  private

  def welcome_user
    font = TTY::Font.new(:doom)
    socket.puts font.write('DUNGEON MAKER').colorize(:green)
  end
end
