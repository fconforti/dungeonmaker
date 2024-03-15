# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Commands::Help do
  let(:socket) { instance_double(TCPSocket) }

  before do
    allow(socket).to receive(:puts)
  end

  describe '.call' do
    context 'with no arguments' do
      subject(:context) { described_class.call(socket:, argument: '') }

      it 'is expected to succeed' do
        expect(context).to be_a_success
      end

      it 'is expected to provide a socket' do
        expect(context.socket).to eq(socket)
      end
    end
  end
end
