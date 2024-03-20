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
        GameSession.new(socket).play
      end
    end
  end
end