# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListCommand do
  let(:socket) { instance_double(TCPSocket) }

  before do
    allow(socket).to receive(:puts)
    allow(socket).to receive(:print)
  end

  describe '.call' do
    context "with 'characters' argument" do
      context 'without a current account' do
        subject(:context) { described_class.call(socket:, argument: 'characters') }

        it 'is expected to show the user a warning message (account required)' do
          expect(context.socket).to have_received(:puts).with(BaseCommand::ACCOUNT_REQUIRED.colorize(:yellow))
        end
      end

      context 'with a current account' do
        let(:account) { create(:account) }

        context 'without characters' do
          subject(:context) { described_class.call(account:, socket:, argument: 'characters') }

          it 'is expected to show the user a warning message (empty)' do
            expect(context.socket).to have_received(:puts).with(ListCommand::EMPTY_LIST.colorize(:yellow))
          end
        end

        context 'with 3 characters' do
          subject(:context) { described_class.call(account:, socket:, argument: 'characters') }

          let!(:race) { create(:race, name: 'Gnome') }
          let!(:klass) { create(:klass, name: 'Druid') }

          before do
            3.times do |i|
              create(:character, name: "character #{i}", account:, race:, klass:)
            end
          end

          it 'is expected to show the user the list of characters' do
            expect(context.socket).to have_received(:puts).with('character 0')
            expect(context.socket).to have_received(:puts).with('character 1')
            expect(context.socket).to have_received(:puts).with('character 2')
          end
        end
      end
    end

    context "with 'dungeons' argument" do
      context 'without a current account' do
        subject(:context) { described_class.call(socket:, argument: 'dungeons') }

        it 'is expected to show the user a warning message (account required)' do
          expect(context.socket).to have_received(:puts).with(BaseCommand::ACCOUNT_REQUIRED.colorize(:yellow))
        end
      end

      context 'with a current account' do
        let(:account) { create(:account) }

        context 'without dungeons' do
          subject(:context) { described_class.call(account:, socket:, argument: 'dungeons') }

          it 'is expected to show the user a warning message (empty)' do
            expect(context.socket).to have_received(:puts).with(ListCommand::EMPTY_LIST.colorize(:yellow))
          end
        end

        context 'with 3 dungeons' do
          subject(:context) { described_class.call(account:, socket:, argument: 'dungeons') }

          before do
            3.times do |i|
              create(:dungeon, name: "dungeon #{i}", account:)
            end
          end

          it 'is expected to show the user the list of dungeons' do
            expect(context.socket).to have_received(:puts).with('dungeon 0')
            expect(context.socket).to have_received(:puts).with('dungeon 1')
            expect(context.socket).to have_received(:puts).with('dungeon 2')
          end
        end
      end
    end

  end
end
