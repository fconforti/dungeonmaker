# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnterCommand do
  let!(:socket) { instance_double(TCPSocket) }
  let!(:session) { GameSession.new(socket) }

  before do
    allow(socket).to receive(:puts)
  end

  describe '.call' do
    context 'without a current account' do
      before do
        session.call_command('enter', 'foo')
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
          session.call_command('enter', 'foo')
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

        context 'with an empty dungeon' do
          let!(:dungeon) { create(:dungeon, account:) }

          before do
            session.call_command('enter', dungeon.name)
          end

          it 'is expected to show the user a error message (no position required)' do
            expect(socket).to have_received(:puts).with(EnterCommand::ROOM_REQUIRED.colorize(:red))
          end
        end

        context 'with a valid dungeon' do
          let!(:dungeon) { create(:dungeon, account:) }
          let!(:room) { create(:room, dungeon:, account:) }

          context "with a current character's position" do
            let!(:character_position) do
              create(:character_position, account:, character:, dungeon:, room:)
            end

            before do
              session.call_command('enter', dungeon.name)
            end

            it 'is expected to show the user a error message (no position required)' do
              expect(socket).to have_received(:puts).with(BaseCommand::NO_POSITION_REQUIRED.colorize(:red))
            end
          end

          context "without a current character's position" do
            before do
              session.call_command('enter', dungeon.name)
            end

            it 'is expected to create the character\'s position' do
              expect(character.position).not_to be_nil
            end

            it 'is expected to assign the dungeon to the character\'s position' do
              expect(character.position.dungeon).to eq(dungeon)
            end

            it 'is expected to assign the room to the character\'s position' do
              expect(character.position.room).to eq(room)
            end

            it 'is expected to print a success message' do
              expect(socket).to have_received(:puts).with("You have entered the #{dungeon.name} dungeon. Good luck!".colorize(:green))
            end
          end
        end
      end
    end
  end
end
