# frozen_string_literal: true

module Print
  extend ActiveSupport::Concern

  included do
    def print(io)
      attributes.each do |key, value|
        io.print "#{key}: ".colorize(:light_blue)
        io.puts value
      end
    end
  end
end
