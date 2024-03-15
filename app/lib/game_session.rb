# frozen_string_literal: true

class GameSession
  include Interactor
  include Inputs
  include Outputs

  def call
    set_current_account
    set_current_character
    set_current_dungeon
    prompt_command
  end

  private

  def prompt_command
    loop do
      context.socket.print '> '
      input = context.socket.gets.chomp
      command_name, argument = input.split
      # begin
        command = Object.const_get("Commands::#{command_name.classify}")
        command.call(account: context.account, socket: context.socket, argument:)
      # rescue StandardError
      #   context.socket.puts "Please check your input. Type 'help' for the command reference.".colorize(:red)
      # end
      break if context.socket.closed?
  
      context.socket.puts
    end  
  end

  def set_current_dungeon
  end

  def set_current_character
    if context.account.characters.any?
      selection = select("Choose a character or create a new one:", context.account.characters, true)
      if selection == Inputs::CREATE_NEW_OPTION
        create_new_context_character
      elsif selection.is_a? Character
        context.character = selection
        context.socket.puts "Thank you! You're now playing as #{context.character.name}.".colorize(:green)
      end
    else
      create_new_context_character
    end
  end

  def create_new_context_character
    context.character = Commands::Create.call(argument: 'character', socket: context.socket, account: context.account)
  end

  def set_current_account
    context.socket.puts 'Welcome to Dungeomn Maker!'
    until context.account.present?
      email = ask("What's your account email?")
      account = Account.find_by(email:)
      account ? signin(account) : signup(email)
    end
  end

  def signin(account)
    password = ask("Enter your password for #{account.email}")
    if account.authenticate(password)
      context.socket.puts "Thank you! You're now logged in.".colorize(:green)
      context.account = account
    else
      context.socket.puts 'Invalid password'.colorize(:red)
    end
  end

  def signup(email)
    account = Account.new(email:)
    account.password = ask('Choose a password:')
    account.password_confirmation = ask('Confirm password:')
    if account.save
      context.socket.puts "Thank you! You're now logged in.".colorize(:green)
      context.account = account
    else
      error_messages(account)
    end
  end

end