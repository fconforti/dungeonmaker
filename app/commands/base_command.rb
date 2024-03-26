# frozen_string_literal: true

class BaseCommand
  include Interactor

  SOMETHING_WENT_WRONG = 'Ops... something went wrong'
  CHARACTER_REQUIRED = 'You need to choose a character first.'
  NO_POSITION_REQUIRED = 'You need to escape the current dungeon first!'
  POSITION_REQUIRED = 'You need to enter a dungeon first!'

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
    context.session.socket.puts prompt.colorize(:magenta)
  end

  def user_input
    context.session.socket.gets.chomp
  end

  def list_collection(collection)
    collection.each_with_index do |model, index|
      context.session.socket.print "[#{index + 1}] ".colorize(:magenta)
      context.session.socket.puts model.name
    end
  end

  def error_messages(model)
    error SOMETHING_WENT_WRONG
    model.errors.full_messages.each do |error|
      error error
    end
  end

  def created_message(model)
    context.session.socket.puts "Your #{model.class.name.humanize.downcase} has been created!".colorize(:green)
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

  def with_account
    return unless block_given?

    if (account = context.session.account)
      yield account
    else
      warning ACCOUNT_REQUIRED
    end
  end

  def with_character
    return unless block_given?

    if (character = context.session.character)
      yield character
    else
      warning CHARACTER_REQUIRED
    end
  end

  def with_position
    return unless block_given?

    if (position = context.session.character.position)
      yield position
    else
      warning POSITION_REQUIRED
    end
  end

  def with_no_account
    return unless block_given?

    if context.session.account.blank?
      yield
    else
      warning NO_ACCOUNT_REQUIRED
    end
  end

  def with_no_position
    return unless block_given?

    if context.session.character.position.blank?
      yield
    else
      warning NO_POSITION_REQUIRED
    end
  end

end
