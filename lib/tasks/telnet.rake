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
        socket.print "Welcome to Dungeon Maker\n"
        loop do
          socket.print '> '
          input = socket.gets.chomp
          command, argument = input.split
          begin
            command = Object.const_get("#{command.classify}Command")
            command.call(socket:, argument:)
          rescue NameError
            socket.puts 'Please check your input'.colorize(:red)
          end
          break if socket.closed?
        end
      end
    end
  end
end
