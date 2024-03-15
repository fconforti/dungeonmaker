# frozen_string_literal: true

class BaseCommand
  include Interactor

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
    context.socket.puts 'Ops... something went wrong:'.colorize(:red)
    model.errors.full_messages.each do |error|
      context.socket.puts error.colorize(:red)
    end
  end

  def created_message(model)
    context.socket.puts
    context.socket.puts "Your #{model.class.name.humanize.downcase} has been created!".colorize(:green)
    model.print(context.socket)
  end

  def already_logged_in
    context.socket.puts "You're already logged in.".colorize(:yellow)
  end

  def already_logged_out
    context.socket.puts "You're already logged out.".colorize(:yellow)
  end

  def account_required
    context.socket.puts "You need to sign in or sign up before.".colorize(:yellow)
  end

  def empty_collection
    context.socket.puts "Empty.".colorize(:yellow) 
  end

end