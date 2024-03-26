module Boom
  extend ActiveSupport::Concern

  included do

    puts "included!"

    before :validate_argument!

    def validate_argument!
      puts "validate_argument!"
      return unless defined? self.class::ARGUMENTS
      unless self.class::ARGUMENTS.include?(context.argument)
        context.fail!(message: "Invalid argument: #{context.argument}")
      end
    end


    def print_error_message
      puts "print_error_message (#{context.failure?})"
      if context.failure?
        context.socket.puts context.message.colorize(:red)
      end
    end
  
  end
end