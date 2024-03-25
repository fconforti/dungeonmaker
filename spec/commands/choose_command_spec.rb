# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChooseCommand do
  let!(:socket) { instance_double(TCPSocket) }
  let!(:account) { create(:account) }
  let!(:session) { GameSession.new(socket) }

  before do
    session.account = account
    allow(socket).to receive(:puts)
  end

  describe '#run' do
    context 'with no arguments' do
      before do
        described_class.new('', session).run
      end

      it 'is expected to show the user an error message (invalid argument)' do
        expect(socket).to have_received(:puts).with('Invalid argument: <empty>'.colorize(:red))
      end
    end

    context 'with an invalid argument' do
      before do
        described_class.new('foo', session).run
      end

      it 'is expected to show the user an error message (invalid argument)' do
        expect(socket).to have_received(:puts).with('Invalid argument: foo'.colorize(:red))
      end
    end

    context "with a valid argument (existing character's name)" do
      let!(:character) { create(:character, account:, name: 'Lucy') }

      before do
        described_class.new('Lucy', session).run
      end

      it 'is expected to change game character' do
        expect(session.character).to eq(character)
      end

      it 'is expected to print a success message' do
        expect(socket).to have_received(:puts).with('You are now playing as Lucy.'.colorize(:green))
      end
    end
  end
end
