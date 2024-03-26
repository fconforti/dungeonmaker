module CommandHooks
  extend ActiveSupport::Concern

  ACCOUNT_REQUIRED = 'You need to sign in or sign up before continuing.'
  NO_ACCOUNT_REQUIRED = 'You need to sign out before continuing.'

  included do

    before :validate_argument!

    def validate_argument!
      return unless defined? self.class::ARGUMENTS
      unless self.class::ARGUMENTS.include?(context.argument)
        context.fail!(message: "Invalid argument: #{context.argument}")
      end
    end

    def require_account!
      context.fail!(message: ACCOUNT_REQUIRED) unless context.session.account
    end
  
    def require_no_account!
      context.fail!(message: NO_ACCOUNT_REQUIRED) if context.session.account
    end  
  
  end
end