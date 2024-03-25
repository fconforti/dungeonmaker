# frozen_string_literal: true

class ChatServer
  def initialize
    @sessions = []
  end

  def add_session(session)
    @sessions << session
  end

  def remove_session(session)
    @sessions.delete(session)
  end

  def say(character, room, message)
    sockets(room.characters).each do |socket|
      socket.puts "[#{character.name}] #{message}".colorize(:light_blue)
    end
  end

  def sockets(characters)
    @sessions.select do |session|
      characters.include? session.character
    end.map(&:socket)
  end
end
