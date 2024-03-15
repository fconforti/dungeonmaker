# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateCommand do
  let(:socket) { instance_double(TCPSocket) }
  let(:account) { create(:account) }

  before do
    create(:race, name: 'Gnome')
    create(:klass, name: 'Druid')
    allow(socket).to receive(:puts)
    allow(socket).to receive(:print)
  end

  describe '.call' do
    context "with 'character' argument" do
      context 'with valid inputs' do
        subject(:context) { described_class.call(account:, socket:, argument: 'character') }

        before do
          allow(socket).to receive(:gets).and_return('1', '1', 'Lucy')
        end

        it 'is expected to prompt the user to choose a race' do
          expect(context.socket).to have_received(:puts).with('Choose a race:'.colorize(:light_blue))
        end

        it 'is expected to prompt the user to choose a class' do
          expect(context.socket).to have_received(:puts).with('Choose a class:'.colorize(:light_blue))
        end

        it 'is expected to prompt the user to choose a name' do
          expect(context.socket).to have_received(:puts).with('Choose a name:'.colorize(:light_blue))
        end

        it 'is expected to print a success message' do
          expect(context.socket).to have_received(:puts).with('Your character has been created!'.colorize(:green))
        end

        it 'is expected to print the character\'s name' do
          expect(context.socket).to have_received(:puts).with('Lucy')
        end
      end

      context 'with invalid inputs (missing race)' do
        subject(:context) { described_class.call(account:, socket:, argument: 'character') }

        before do
          allow(socket).to receive(:gets).and_return('-1', '1', 'Lucy')
        end

        it 'is expected to print an error message (Race must exist)' do
          expect(context.socket).to have_received(:puts).with('Race must exist'.colorize(:red))
        end
      end

      context 'with invalid inputs (missing class)' do
        subject(:context) { described_class.call(account:, socket:, argument: 'character') }

        before do
          allow(socket).to receive(:gets).and_return('1', '-1', 'Lucy')
        end

        it 'is expected to print an error message (Klass must exist)' do
          expect(context.socket).to have_received(:puts).with('Klass must exist'.colorize(:red))
        end
      end

      context 'with invalid inputs (missing name)' do
        subject(:context) { described_class.call(account:, socket:, argument: 'character') }

        before do
          allow(socket).to receive(:gets).and_return('1', '1', '')
        end

        it 'is expected to print an error message (Name can\'t be blank)' do
          expect(context.socket).to have_received(:puts).with('Name can\'t be blank'.colorize(:red))
        end
      end

      context 'with invalid inputs (duplicate name)' do
        subject(:context) { described_class.call(account:, socket:, argument: 'character') }

        before do
          create(:character, name: 'Lucy')
          allow(socket).to receive(:gets).and_return('1', '1', 'Lucy')
        end

        it 'is expected to print an error message (Name has already been taken)' do
          expect(context.socket).to have_received(:puts).with('Name has already been taken'.colorize(:red))
        end
      end
    end

    context "with 'dungeon' argument" do
      context 'with valid inputs' do
        subject(:context) { described_class.call(account:, socket:, argument: 'dungeon') }

        before do
          allow(socket).to receive(:gets).and_return('Dark rooms')
        end

        it 'is expected to prompt the user to choose a name' do
          expect(context.socket).to have_received(:puts).with('Choose a name:'.colorize(:light_blue))
        end

        it 'is expected to print a success message' do
          expect(context.socket).to have_received(:puts).with('Your dungeon has been created!'.colorize(:green))
        end

        it 'is expected to print the dungeon\'s name' do
          expect(context.socket).to have_received(:puts).with('Dark rooms')
        end
      end

      context 'with invalid inputs (missing name)' do
        subject(:context) { described_class.call(account:, socket:, argument: 'dungeon') }

        before do
          allow(socket).to receive(:gets).and_return('')
        end

        it 'is expected to print an error message (Name can\'t be blank)' do
          expect(context.socket).to have_received(:puts).with('Name can\'t be blank'.colorize(:red))
        end
      end

      context 'with invalid inputs (duplicate name)' do
        subject(:context) { described_class.call(account:, socket:, argument: 'dungeon') }

        before do
          create(:dungeon, name: 'Dark rooms')
          allow(socket).to receive(:gets).and_return('Dark rooms')
        end

        it 'is expected to print an error message (Name has already been taken)' do
          expect(context.socket).to have_received(:puts).with('Name has already been taken'.colorize(:red))
        end
      end
    end
  end
end
