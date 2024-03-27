# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListCommand do
  let!(:socket) { instance_double(TCPSocket) }
  let!(:session) { GameSession.new(socket) }

  before do
    allow(socket).to receive(:puts)
    allow(socket).to receive(:print)
  end

  describe '.call' do
    context "with 'characters' argument" do
      context 'without a current account' do
        before do
          described_class.new('characters', session).run
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

        context 'without characters' do
          before do
            described_class.new('characters', session).run
          end

          it 'is expected to show the user a error message (empty)' do
            expect(socket).to have_received(:puts).with(ListCommand::EMPTY_LIST.colorize(:red))
          end
        end

        context 'with 3 characters' do
          let!(:race) { create(:race, name: 'Gnome') }
          let!(:klass) { create(:klass, name: 'Druid') }

          before do
            3.times do |i|
              create(:character, name: "character #{i}", account:, race:, klass:)
            end
            described_class.new('characters', session).run
          end

          it 'is expected to show the user the list of characters' do
            expect(socket).to have_received(:puts).with('character 0')
            expect(socket).to have_received(:puts).with('character 1')
            expect(socket).to have_received(:puts).with('character 2')
          end
        end
      end
    end

    context "with 'dungeons' argument" do
      context 'without a current account' do
        before do
          described_class.new('dungeons', session).run
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

        context 'without dungeons' do
          before do
            described_class.new('dungeons', session).run
          end

          it 'is expected to show the user a error message (empty)' do
            expect(socket).to have_received(:puts).with(ListCommand::EMPTY_LIST.colorize(:red))
          end
        end

        context 'with 3 dungeons' do
          before do
            3.times do |i|
              create(:dungeon, name: "dungeon #{i}", account:)
            end
            described_class.new('dungeons', session).run
          end

          it 'is expected to show the user the list of dungeons' do
            expect(socket).to have_received(:puts).with('dungeon 0')
            expect(socket).to have_received(:puts).with('dungeon 1')
            expect(socket).to have_received(:puts).with('dungeon 2')
          end
        end
      end
    end
  end
end
