# frozen_string_literal: true

require 'socket'

server = TCPServer.new(2000)

Rails.logger.debug 'Server running on port 2000...'

loop do
  tcp_socket = server.accept
  Thread.new(tcp_socket) do |socket|
    socket.puts "What's your name?"
    name = socket.gets.chomp
    socket.puts "Welcome, #{name}!"
    socket.close
  end
end
