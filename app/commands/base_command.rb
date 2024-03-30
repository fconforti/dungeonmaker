# frozen_string_literal: true

class BaseCommand
  include Interactor

  SOMETHING_WENT_WRONG = 'Ops... something went wrong'
  CHARACTER_REQUIRED = 'You need to choose a character first.'
  NO_POSITION_REQUIRED = 'You need to escape the current dungeon first!'
  POSITION_REQUIRED = 'You need to enter a dungeon first!'
  ACCOUNT_REQUIRED = 'You need to sign in or sign up before continuing.'
  NO_ACCOUNT_REQUIRED = 'You need to sign out before continuing.'

  def select(prompt, collection)
    print_prompt(prompt)
    list_collection(collection)
    collection[user_input.to_i - 1]
  end

  def ask(prompt)
    print_prompt(prompt)
    user_input
  end

  private

  def print_prompt(prompt)
    context.session.socket.puts prompt.colorize(:light_blue)
  end

  def user_input
    context.session.socket.gets.chomp
  end

  def list_collection(collection)
    collection.each_with_index do |model, index|
      context.session.socket.print "[#{index + 1}] ".colorize(:light_blue)
      name = model.is_a?(String) ? model : model.name
      context.session.socket.puts name
    end
  end

  def error_messages(model)
    error SOMETHING_WENT_WRONG
    model.errors.full_messages.each do |error|
      error error
    end
  end

  def created_message(model)
    context.session.socket.puts "Your #{model.class.name.underscore.humanize.downcase} has been created!".colorize(:green)
    model.print(context.session.socket)
  end

  def success(message)
    context.session.socket.puts message.colorize(:green)
  end

  def warning(message)
    context.session.socket.puts message.colorize(:yellow)
  end

  def error(message)
    context.session.socket.puts message.colorize(:red)
  end

  def validate_argument!
    return unless defined? self.class::ARGUMENTS
    unless self.class::ARGUMENTS.include?(context.argument)
      invalid_argument!(context.argument)
    end
  end

  def invalid_argument!(argument)
    argument = '<blank>' if argument.blank?
    context.fail!(message: "Invalid argument: #{argument}")
  end

  def require_account!
    context.fail!(message: ACCOUNT_REQUIRED) unless context.session.account
  end

  def require_character!
    context.fail!(message: CHARACTER_REQUIRED) unless context.session.character
  end

  def require_position!
    context.fail!(message: POSITION_REQUIRED) unless context.session.character.position
  end

  def require_no_account!
    context.fail!(message: NO_ACCOUNT_REQUIRED) if context.session.account
  end

  def require_no_position!
    context.fail!(message: NO_POSITION_REQUIRED) if context.session.character.position
  end

end
