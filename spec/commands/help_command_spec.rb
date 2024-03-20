# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HelpCommand do
  let(:socket) { instance_double(TCPSocket) }
  let(:session) { GameSession.new(socket) }

  before do
    allow(socket).to receive(:puts)
  end

  describe '#run' do
    context 'with no arguments' do
      before do
        described_class.new('', session).run
      end

      it 'is expected to succeed' do
        expect(socket).to have_received(:puts)
      end
    end
  end
end
