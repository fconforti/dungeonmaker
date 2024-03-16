# frozen_string_literal: true

class GameSession
  attr_reader :socket, :account

  def initialize(socket)
    @socket = socket
  end

  def play
    loop do
      @socket.puts
      @socket.print '> '
      input = @socket.gets.chomp
      command_name, argument = input.split
      # begin
      command = Object.const_get("#{command_name.classify}Command")
      context = command.call(account:, socket:, argument:)
      @account = context.account
      # rescue StandardError
      #   context.socket.puts "Please check your input. Type 'help' for the command reference.".colorize(:red)
      # end
      break if @socket.closed?
    end
  end
end
