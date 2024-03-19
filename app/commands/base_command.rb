# frozen_string_literal: true

class BaseCommand
  SOMETHING_WENT_WRONG = 'Ops... something went wrong'
  ACCOUNT_REQUIRED = 'You need to sign in or sign up before continuing.'
  NO_ACCOUNT_REQUIRED = 'You need to sign out before continuing.'
  
  attr_reader :argument, :session

  def initialize(argument, session)
    @argument = argument
    @session = session
  end

  def select(prompt, collection)
    print_prompt(prompt)
    list_collection(collection)
    print_cursor
    collection[get_user_input.to_i - 1]
  end

  def ask(prompt)
    print_prompt(prompt)
    print_cursor
    get_user_input
  end

  private

  def print_prompt(prompt)
    session.socket.puts prompt.colorize(:light_blue)
  end

  def print_cursor
    session.socket.print '> '
  end

  def get_user_input
    session.socket.gets.chomp
  end

  def list_collection(collection)
    collection.each_with_index do |model, index|
      session.socket.print "[#{index + 1}] ".colorize(:light_blue)
      session.socket.puts model.name
    end
  end

  def invalid_argument(argument)
    session.socket.puts
    session.socket.puts "Invalid argument: #{argument}".colorize(:red)
  end

  def error_messages(model)
    session.socket.puts
    error SOMETHING_WENT_WRONG
    model.errors.full_messages.each do |error|
      error error
    end
  end

  def created_message(model)
    session.socket.puts
    session.socket.puts "Your #{model.class.name.humanize.downcase} has been created!".colorize(:green)
    model.print(session.socket)
  end

  def success(message)
    session.socket.puts message.colorize(:green)
  end

  def warning(message)
    session.socket.puts message.colorize(:yellow)
  end

  def error(message)
    session.socket.puts message.colorize(:red)
  end

  def with_no_account
    return unless block_given?
    if session.account.blank?
      yield
    else
      warning NO_ACCOUNT_REQUIRED
    end
  end

  def with_account
    return unless block_given?
    if session.account.present?
      yield
    else
      warning ACCOUNT_REQUIRED
    end
  end

end
