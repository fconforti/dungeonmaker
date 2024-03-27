# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SayCommand do
  let!(:chat_server) { ChatServer.new }
  let!(:socket_01) { instance_double(TCPSocket) }
  let!(:session_01) { GameSession.new(socket_01, chat_server) }
  let!(:socket_02) { instance_double(TCPSocket) }
  let!(:session_02) { GameSession.new(socket_02, chat_server) }
  let!(:socket_03) { instance_double(TCPSocket) }
  let!(:session_03) { GameSession.new(socket_03, chat_server) }

  before do
    allow(socket_01).to receive(:puts)
    allow(socket_02).to receive(:puts)
    allow(socket_03).to receive(:puts)
  end

  describe '.call' do
    context 'without a current account' do
      before do
        described_class.new('hello world!', session_01).run
      end

      it 'is expected to show the user a error message (account required)' do
        expect(socket_01).to have_received(:puts).with(BaseCommand::ACCOUNT_REQUIRED.colorize(:red))
      end
    end

    context 'with a current account' do
      let!(:account) { create(:account) }

      before do
        session_01.account = account
      end

      context 'without a current character' do
        before do
          described_class.new('hello world!', session_01).run
        end

        it 'is expected to show the user a error message (character required)' do
          expect(socket_01).to have_received(:puts).with(BaseCommand::CHARACTER_REQUIRED.colorize(:red))
        end
      end

      context 'with a current character' do
        let!(:character_01) { create(:character, name: 'character 01', account:) }

        before do
          session_01.character = character_01
        end

        context 'without a position' do
          before do
            described_class.new('hello world!', session_01).run
          end

          it 'is expected to show the user a error message (position required)' do
            expect(socket_01).to have_received(:puts).with(EnterCommand::POSITION_REQUIRED.colorize(:red))
          end
        end

        context 'with a valid position' do
          let!(:dungeon) { create(:dungeon, account:) }
          let!(:room_01) { create(:room, dungeon:, account:) }

          before do
            create(:character_position, character: character_01, dungeon:, room: room_01, account:)
          end

          context 'with other characters' do
            let!(:account_02) { create(:account) }
            let!(:room_02) { create(:room, dungeon:, account:) }
            let!(:exit_0102) do
              create(:exit, dungeon:, from_room: room_01, to_room: room_02, direction: 'north', account:)
            end
            let!(:account_03) { create(:account) }

            let!(:character_02) { create(:character, name: 'character 02', account: account_02) }
            let!(:character_03) { create(:character, name: 'character 03', account: account_03) }

            before do
              session_02.character = character_02
              session_03.character = character_03
              create(:character_position, character: character_02, dungeon:, room: room_01, account: account_02)
              create(:character_position, character: character_03, dungeon:, room: room_02, account: account_03)
              described_class.new('hello world!', session_01).run
            end

            it 'is expected to send a message to all characters in the same room' do
              expect(socket_01).to have_received(:puts).with("[#{character_01.name}] hello world!".colorize(:light_blue))
              expect(socket_02).to have_received(:puts).with("[#{character_01.name}] hello world!".colorize(:light_blue))
              expect(socket_03).not_to have_received(:puts).with("[#{character_01.name}] hello world!".colorize(:light_blue))
            end
          end
        end
      end
    end
  end
end
