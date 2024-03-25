# frozen_string_literal: true

desc 'Starts a telnet server.'

namespace :telnet do
  task server: :environment do
    require 'socket'

    tcp_server = TCPServer.new(2000)
    chat_server = ChatServer.new

    puts 'Server running on port 2000...'

    loop do
      tcp_socket = tcp_server.accept
      Thread.new(tcp_socket) do |socket|
        GameSession.new(socket, chat_server).play
      end
    end
  end
end
