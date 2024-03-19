# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateCommand do
  let(:socket) { instance_double(TCPSocket) }
  let(:account) { create(:account) }
  let(:session) { GameSession.new(socket, account) }

  before do
    create(:race, name: 'Gnome')
    create(:klass, name: 'Druid')
    allow(socket).to receive(:puts)
    allow(socket).to receive(:print)
  end

  describe '#run' do
    context "with 'character' argument" do
      context 'with valid inputs' do

        before do
          allow(socket).to receive(:gets).and_return('1', '1', 'Lucy')
          described_class.new('character', session).run
        end

        it 'is expected to prompt the user to choose a race' do
          expect(socket).to have_received(:puts).with('Choose a race:'.colorize(:light_blue))
        end

        it 'is expected to prompt the user to choose a klass' do
          expect(socket).to have_received(:puts).with('Choose a class:'.colorize(:light_blue))
        end

        it 'is expected to prompt the user to choose a name' do
          expect(socket).to have_received(:puts).with('Choose a name:'.colorize(:light_blue))
        end

        it 'is expected to print a success message' do
          expect(socket).to have_received(:puts).with('Your character has been created!'.colorize(:green))
        end

        it 'is expected to print the character\'s name' do
          expect(socket).to have_received(:puts).with('Lucy')
        end
      end

      context 'with invalid inputs (missing race)' do

        before do
          allow(socket).to receive(:gets).and_return('-1', '1', 'Lucy')
          described_class.new('character', session).run
        end

        it 'is expected to print an error message (Race must exist)' do
          expect(socket).to have_received(:puts).with('Race must exist'.colorize(:red))
        end
      end

      context 'with invalid inputs (missing class)' do

        before do
          allow(socket).to receive(:gets).and_return('1', '-1', 'Lucy')
          described_class.new('character', session).run
        end

        it 'is expected to print an error message (Klass must exist)' do
          expect(socket).to have_received(:puts).with('Klass must exist'.colorize(:red))
        end
      end

      context 'with invalid inputs (missing name)' do

        before do
          allow(socket).to receive(:gets).and_return('1', '1', '')
          described_class.new('character', session).run
        end

        it 'is expected to print an error message (Name can\'t be blank)' do
          expect(socket).to have_received(:puts).with('Name can\'t be blank'.colorize(:red))
        end
      end

      context 'with invalid inputs (duplicate name)' do

        before do
          create(:character, name: 'Lucy')
          allow(socket).to receive(:gets).and_return('1', '1', 'Lucy')
          described_class.new('character', session).run
        end

        it 'is expected to print an error message (Name has already been taken)' do
          expect(socket).to have_received(:puts).with('Name has already been taken'.colorize(:red))
        end
      end
    end

    context "with 'dungeon' argument" do
      context 'with valid inputs' do

        before do
          allow(socket).to receive(:gets).and_return('Dark rooms')
          described_class.new('dungeon', session).run
        end

        it 'is expected to prompt the user to choose a name' do
          expect(socket).to have_received(:puts).with('Choose a name:'.colorize(:light_blue))
        end

        it 'is expected to print a success message' do
          expect(socket).to have_received(:puts).with('Your dungeon has been created!'.colorize(:green))
        end

        it 'is expected to print the dungeon\'s name' do
          expect(socket).to have_received(:puts).with('Dark rooms')
        end
      end

      context 'with invalid inputs (missing name)' do

        before do
          allow(socket).to receive(:gets).and_return('')
          described_class.new('dungeon', session).run
        end

        it 'is expected to print an error message (Name can\'t be blank)' do
          expect(socket).to have_received(:puts).with('Name can\'t be blank'.colorize(:red))
        end
      end

      context 'with invalid inputs (duplicate name)' do

        before do
          create(:dungeon, name: 'Dark rooms')
          allow(socket).to receive(:gets).and_return('Dark rooms')
          described_class.new('dungeon', session).run
        end

        it 'is expected to print an error message (Name has already been taken)' do
          expect(socket).to have_received(:puts).with('Name has already been taken'.colorize(:red))
        end
      end
    end

  end
end
