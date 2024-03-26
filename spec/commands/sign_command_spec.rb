# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignCommand do
  let!(:socket) { instance_double(TCPSocket) }
  let!(:session) { GameSession.new(socket) }

  before do
    allow(socket).to receive(:puts)
    allow(socket).to receive(:print)
  end

  describe '#run' do
    context "with an invalid argument" do
      before do
        session.call_command('sign', 'foo')
      end

      it 'is expected to show the user a error message (invalid argument)' do
        expect(socket).to have_received(:puts).with("Invalid argument: foo".colorize(:red))
      end
    end

    context "with 'up' argument" do
      context 'without a current account' do
        context 'with valid inputs' do
          before do
            allow(socket).to receive(:gets).and_return('filippo@example.com', 'secret', 'secret')
            session.call_command('sign', 'up')
          end

          it 'is expected to prompt the user to enter email' do
            expect(socket).to have_received(:puts).with('Enter your email:'.colorize(:magenta))
          end

          it 'is expected to prompt the user to choose a password' do
            expect(socket).to have_received(:puts).with('Choose a password:'.colorize(:magenta))
          end

          it 'is expected to prompt the user to confirm password' do
            expect(socket).to have_received(:puts).with('Confirm password:'.colorize(:magenta))
          end

          it 'is expected to show the user a success message' do
            expect(socket).to have_received(:puts).with(SignCommand::SIGNED_UP.colorize(:green))
          end
        end

        context 'with invalid inputs (empty email)' do
          before do
            allow(socket).to receive(:gets).and_return('', 'secret', 'secret')
            session.call_command('sign', 'up')
          end

          it 'is expected to show the user an error message (something went wrong)' do
            expect(socket).to have_received(:puts).with(BaseCommand::SOMETHING_WENT_WRONG.colorize(:red))
          end
        end

        context 'with invalid inputs (empty password)' do
          before do
            allow(socket).to receive(:gets).and_return('filippo@example.com', '', 'secret')
            session.call_command('sign', 'up')
          end

          it 'is expected to show the user an error message (something went wrong)' do
            expect(socket).to have_received(:puts).with(BaseCommand::SOMETHING_WENT_WRONG.colorize(:red))
          end
        end

        context 'with invalid inputs (password confirmation not matching)' do
          before do
            allow(socket).to receive(:gets).and_return('filippo@example.com', 'secret', 'notmatching')
            session.call_command('sign', 'up')
          end

          it 'is expected to show the user an error message (something went wrong)' do
            expect(socket).to have_received(:puts).with(BaseCommand::SOMETHING_WENT_WRONG.colorize(:red))
          end
        end
      end

      context 'with a current account' do
        let!(:account) { create(:account) }

        before do
          session.account = account
          session.call_command('sign', 'up')
        end

        it 'is expected to show the user a error message (already signed in)' do
          expect(socket).to have_received(:puts).with(CommandHooks::NO_ACCOUNT_REQUIRED.colorize(:red))
        end
      end
    end

    context "with 'in' argument" do
      context 'with an existing account' do
        let!(:account) do
          create(:account, email: 'filippo@example.com', password: 'secret', password_confirmation: 'secret')
        end

        context 'without a current account' do
          context 'with valid inputs' do
            before do
              allow(socket).to receive(:gets).and_return('filippo@example.com', 'secret')
              session.call_command('sign', 'in')
            end

            it 'is expected to prompt the user to enter email' do
              expect(socket).to have_received(:puts).with('Enter your email:'.colorize(:magenta))
            end

            it 'is expected to prompt the user to enter password' do
              expect(socket).to have_received(:puts).with('Enter your password:'.colorize(:magenta))
            end

            it 'is expected to show the user a success message' do
              expect(socket).to have_received(:puts).with(SignCommand::SIGNED_IN.colorize(:green))
            end
          end
        end

        context 'with a current account' do
          let!(:account) { create(:account) }

          before do
            session.account = account
            session.call_command('sign', 'in')
          end

          it 'is expected to show the user a error message (already signed in)' do
            expect(socket).to have_received(:puts).with(CommandHooks::NO_ACCOUNT_REQUIRED.colorize(:red))
          end
        end
      end
    end

    context "with 'out' argument" do
      context 'with an existing account' do
        let!(:account) do
          create(:account, email: 'filippo@example.com', password: 'secret', password_confirmation: 'secret')
        end

        context 'without a current account' do
          before do
            session.call_command('sign', 'out')
          end

          it 'is expected to show the user a error message' do
            expect(socket).to have_received(:puts).with(CommandHooks::ACCOUNT_REQUIRED.colorize(:red))
          end
        end

        context 'with a current account' do
          before do
            session.account = account
            session.call_command('sign', 'out')
          end

          it 'is expected to show the user a success message' do
            expect(socket).to have_received(:puts).with(SignCommand::SIGNED_OUT.colorize(:green))
          end
        end
      end
    end
  end
end
