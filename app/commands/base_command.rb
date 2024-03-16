# frozen_string_literal: true

class BaseCommand
  include Interactor

  SOMETHING_WENT_WRONG = "Ops... something went wrong"

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
    context.socket.puts prompt.colorize(:light_blue)
  end

  def print_cursor
    context.socket.print '> '
  end

  def get_user_input
    context.socket.gets.chomp
  end

  def list_collection(collection)
    collection.each_with_index do |model, index|
      context.socket.print "[#{index + 1}] ".colorize(:light_blue)
      context.socket.puts model.name
    end
  end

  def invalid_argument(argument)
    context.socket.puts
    context.socket.puts "Invalid argument: #{argument}".colorize(:red)
  end

  def error_messages(model)
    context.socket.puts
    error SOMETHING_WENT_WRONG
    model.errors.full_messages.each do |error|
      error error
    end
  end

  def created_message(model)
    context.socket.puts
    context.socket.puts "Your #{model.class.name.humanize.downcase} has been created!".colorize(:green)
    model.print(context.socket)
  end

  def account_required
    context.socket.puts "You need to sign in or sign up before.".colorize(:yellow)
  end

  def empty_collection
    context.socket.puts "Empty.".colorize(:yellow) 
  end

  def success(message)
    context.socket.puts message.colorize(:green)
  end

  def warning(message)
    context.socket.puts message.colorize(:yellow)
  end

  def error(message)
    context.socket.puts message.colorize(:red)    
  end

end