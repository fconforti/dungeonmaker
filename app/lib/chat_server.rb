# frozen_string_literal: true

class ChatServer

  def initialize
    @sessions = []
  end

  def add_session(session)
    @sessions << session
  end

  def say(character, room, message)
    room_characters = room.characters - [character]
    sockets(room_characters).each do |socket|
      socket.puts "[#{character.name}] #{message}"
    end
  end

  def sockets(characters)
    @sessions.select do |session|
      characters.include? session.character
    end.map do |session|
      session.socket
    end
  end

end
