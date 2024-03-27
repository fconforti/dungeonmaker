# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModeCommand do
  let!(:socket) { instance_double(TCPSocket) }
  let!(:session) { GameSession.new(socket) }

  before do
    allow(socket).to receive(:puts)
  end

  describe '.call' do
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

    ModeCommand::ARGUMENTS.each do |argument|
      context "with a valid argument (#{argument})" do
        before do
          described_class.new(argument, session).run
        end

        it 'is expected to change game mode' do
          expect(session.mode).to eq(argument)
        end

        it 'is expected to print a success message' do
          expect(socket).to have_received(:puts).with("Game mode changed: #{argument}".colorize(:green))
        end
      end
    end
  end
end
