# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignCommand do
  let(:socket) { instance_double(TCPSocket) }

  before do
    allow(socket).to receive(:puts)
    allow(socket).to receive(:print)
  end

  describe '.call' do
    context "with 'up' argument" do
      context 'without a current account' do
        context 'with valid inputs' do
          subject(:context) { described_class.call(socket:, argument: 'up') }

          before do
            allow(socket).to receive(:gets).and_return('filippo@example.com', 'secret', 'secret')
          end
  
          it 'is expected to prompt the user to enter email' do
            expect(context.socket).to have_received(:puts).with('Enter your email:'.colorize(:light_blue))
          end
  
          it 'is expected to prompt the user to choose a password' do
            expect(context.socket).to have_received(:puts).with('Choose a password:'.colorize(:light_blue))
          end

          it 'is expected to prompt the user to confirm password' do
            expect(context.socket).to have_received(:puts).with('Confirm password:'.colorize(:light_blue))
          end

          it 'is expected to show the user a success message' do
            expect(context.socket).to have_received(:puts).with(SignCommand::SIGNED_UP.colorize(:green))
          end

        end

        context 'with invalid inputs (empty email)' do
          subject(:context) { described_class.call(socket:, argument: 'up') }

          before do
            allow(socket).to receive(:gets).and_return('', 'secret', 'secret')
          end
  
          it 'is expected to show the user an error message (something went wrong)' do
            expect(context.socket).to have_received(:puts).with(BaseCommand::SOMETHING_WENT_WRONG.colorize(:red))
          end

        end

        context 'with invalid inputs (empty password)' do
          subject(:context) { described_class.call(socket:, argument: 'up') }

          before do
            allow(socket).to receive(:gets).and_return('filippo@example.com', '', 'secret')
          end
  
          it 'is expected to show the user an error message (something went wrong)' do
            expect(context.socket).to have_received(:puts).with(BaseCommand::SOMETHING_WENT_WRONG.colorize(:red))
          end

        end

        context 'with invalid inputs (password confirmation not matching)' do
          subject(:context) { described_class.call(socket:, argument: 'up') }

          before do
            allow(socket).to receive(:gets).and_return('filippo@example.com', 'secret', 'notmatching')
          end
  
          it 'is expected to show the user an error message (something went wrong)' do
            expect(context.socket).to have_received(:puts).with(BaseCommand::SOMETHING_WENT_WRONG.colorize(:red))
          end

        end

      end

      context 'with a current account' do

        let(:account) { create :account }

        subject(:context) { described_class.call(account:, socket:, argument: 'up') }

        it 'is expected to show the user a warning message (already signed in)' do
          expect(context.socket).to have_received(:puts).with(SignCommand::ALREADY_SIGNED_IN.colorize(:yellow))
        end

      end
    end

    context "with 'in' argument" do
      context "with an existing account" do

        let!(:account) { create :account, email: "filippo@example.com", password: "secret", password_confirmation: "secret" }

        context 'without a current account' do
          context 'with valid inputs' do
            subject(:context) { described_class.call(socket:, argument: 'in') }
  
            before do
              allow(socket).to receive(:gets).and_return('filippo@example.com', 'secret')
            end
    
            it 'is expected to prompt the user to enter email' do
              expect(context.socket).to have_received(:puts).with('Enter your email:'.colorize(:light_blue))
            end
    
            it 'is expected to prompt the user to enter password' do
              expect(context.socket).to have_received(:puts).with('Enter your password:'.colorize(:light_blue))
            end
  
            it 'is expected to show the user a success message ' do
              expect(context.socket).to have_received(:puts).with(SignCommand::SIGNED_IN.colorize(:green))
            end
  
          end
  
        end
  
        context 'with a current account' do
  
          subject(:context) { described_class.call(account:, socket:, argument: 'in') }
  
          it 'is expected to show the user a warning message (already signed in)' do
            expect(context.socket).to have_received(:puts).with(SignCommand::ALREADY_SIGNED_IN.colorize(:yellow))
          end
  
        end
  
      end
    end

    context "with 'out' argument" do
      context "with an existing account" do

        let!(:account) { create :account, email: "filippo@example.com", password: "secret", password_confirmation: "secret" }

        context 'without a current account' do
  
          subject(:context) { described_class.call(socket:, argument: 'out') }

          it 'is expected to show the user a warning message ' do
            expect(context.socket).to have_received(:puts).with(SignCommand::ALREADY_SIGNED_OUT.colorize(:yellow))
          end
        
        end
  
        context 'with a current account' do
  
          subject(:context) { described_class.call(account:, socket:, argument: 'out') }

          it 'is expected to show the user a success message ' do
            expect(context.socket).to have_received(:puts).with(SignCommand::SIGNED_OUT.colorize(:green))
          end
  
        end
  
      end
    end


  end
end
