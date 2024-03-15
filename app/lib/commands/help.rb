# frozen_string_literal: true
module Commands
  class Help
    include Interactor

    def call
      context.socket.puts output.colorize(:green)
    end

    private

    def output
      commands = YAML.load_file(Rails.root.join('config/help.yml'))
      commands.to_yaml
    end
  end
end