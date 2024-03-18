# frozen_string_literal: true

class GameSession
  attr_accessor :socket, :account

  def initialize(socket, account=nil)
    @socket = socket
    @account = account
  end

  def play
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
