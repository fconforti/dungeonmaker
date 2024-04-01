# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PassCommand do
  let!(:socket) { instance_double(TCPSocket) }
  let!(:session) { GameSession.new(socket) }

  before do
    allow(socket).to receive(:puts)
  end

  describe '.call' do
    context 'without a current account' do
      before do
        session.call_command('pass', 'foo')
      end

      it 'is expected to show the user a error message (account required)' do
        expect(socket).to have_received(:puts).with(BaseCommand::ACCOUNT_REQUIRED.colorize(:red))
      end
    end

    context 'with a current account' do
      let!(:account) { create(:account) }

      before do
        session.account = account
      end

      context 'without a current character' do
        before do
          session.call_command('pass', 'foo')
        end

        it 'is expected to show the user a error message (character required)' do
          expect(socket).to have_received(:puts).with(BaseCommand::CHARACTER_REQUIRED.colorize(:red))
        end
      end

      context 'with a current character' do
        let!(:character) { create(:character, account:) }

        before do
          session.character = character
        end

        context 'without a position' do
          before do
            session.call_command('pass', 'foo')
          end

          it 'is expected to show the user a error message (position required)' do
            expect(socket).to have_received(:puts).with(EnterCommand::POSITION_REQUIRED.colorize(:red))
          end
        end

        context 'with a valid position' do
          let!(:dungeon) { create(:dungeon, account:) }
          let!(:from_room) { create(:room, dungeon:, account:) }
          let!(:to_room) { create(:room, dungeon:, account:) }
          let!(:exit) { create :exit, account:, dungeon:, from_room:, to_room: }
          let!(:character_position) { create :character_position, character:, dungeon:, room: from_room, account: }

          context 'with an obstacle' do
            let!(:key) { create :key, account: account, dungeon: dungeon }
            let!(:obstacle) { create :obstacle, account: account, dungeon: dungeon, exit: exit, item: key }

            before do
              session.call_command('pass', obstacle.name)
            end

            it 'is expected to show the user a error message (obstacle)' do
              expect(socket).to have_received(:puts).with("You can't pass: #{obstacle.name}".colorize(:red))
            end
          end

        end
      end
    end
  end
end
