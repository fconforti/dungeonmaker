# frozen_string_literal: true

class HelpCommand < BaseCommand
  def run
    session.socket.puts output.colorize(:green)
  end

  private

  def output
    commands = YAML.load_file(Rails.root.join('config/help.yml'))
    commands.to_yaml
  end
end
