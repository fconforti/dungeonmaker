# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoCommand do
  let!(:socket) { instance_double(TCPSocket) }
  let!(:session) { GameSession.new(socket) }

  before do
    allow(socket).to receive(:puts)
  end

  describe '.call' do
    context 'without a current account' do
      before do
        session.call_command('go', 'north')
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
          session.call_command('go', 'north')
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
            session.call_command('go', 'north')
          end

          it 'is expected to show the user a error message (position required)' do
            expect(socket).to have_received(:puts).with(EnterCommand::POSITION_REQUIRED.colorize(:red))
          end
        end

        context 'with a valid position' do
          let!(:dungeon) { create(:dungeon, account:) }
          let!(:room_02) { create(:room, dungeon:, account:) }
          let!(:room_03) { create(:room, dungeon:, account:) }
          let!(:exit_0102) do
            create(:exit, dungeon:, from_room: room_01, to_room: room_02, direction: 'north', account:)
          end
          let!(:exit_0203) do
            create(:exit, dungeon:, from_room: room_02, to_room: room_03, direction: 'east', account:)
          end
          let!(:room_01) { create(:room, dungeon:, account:) }

          before do
            create(:character_position, character:, dungeon:, room: room_01, account:)
          end

          context 'with invalid direction' do
            before do
              session.call_command('go', 'south')
            end

            it 'is expected to show the user a error message (no exits nor entrances)' do
              expect(socket).to have_received(:puts).with('There are no exits nor entrances at the south'.colorize(:red))
            end
          end

          context 'with valid directions (exits)' do
            before do
              session.call_command('go', 'north')
              session.call_command('go', 'east')
            end

            it 'is expected to chage the character position' do
              expect(character.position.room).to eq(room_03)
            end
          end

          context 'with valid directions (exits and entrance)' do
            before do
              session.call_command('go', 'north')
              session.call_command('go', 'east')
              session.call_command('go', 'west')
            end

            it 'is expected to chage the character position' do
              expect(character.position.room).to eq(room_02)
            end
          end
        end
      end
    end
  end
end
