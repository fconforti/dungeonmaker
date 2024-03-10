# frozen_string_literal: true

desc 'Starts a telnet server.'

namespace :telnet do
  task server: :environment do
    require 'socket'

    server = TCPServer.new(2000)

    puts 'Server running on port 2000...'

    loop do
      tcp_socket = server.accept
      Thread.new(tcp_socket) do |socket|
        socket.puts 'Welcome to Dungeon Maker!'.colorize(:green)


        loop do
          socket.print '> '
          input = socket.gets.chomp
          command_name, argument = input.split
          begin
            command = Object.const_get("#{command_name.classify}Command")
            command.call(socket:, argument:)
          rescue
            socket.puts "Please check your input. Type 'help' for the command reference.".colorize(:red)
          end
          break if socket.closed?

          socket.puts
        end
      end
    end
  end
end
