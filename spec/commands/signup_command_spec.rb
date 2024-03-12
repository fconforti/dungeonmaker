# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignupCommand do
  let(:socket) { instance_double(TCPSocket) }

  before do
    allow(socket).to receive(:puts)
    allow(socket).to receive(:print)
  end

  describe '.call' do
    subject(:context) { described_class.call(socket:, argument: 'character') }

    context 'with valid inputs' do
      before do
        allow(socket).to receive(:gets).and_return('foo@example.com', 'password', 'password')
      end

      it 'is expected to prompt the user to enter an email address' do
        expect(context.socket).to have_received(:puts).with('Email address:'.colorize(:light_blue))
      end

      it 'is expected to prompt the user to choose a password' do
        expect(context.socket).to have_received(:puts).with('Choose a password:'.colorize(:light_blue))
      end

      it 'is expected to prompt the user to confirm password' do
        expect(context.socket).to have_received(:puts).with('Confirm password:'.colorize(:light_blue))
      end

      it 'is expected to print a success message' do
        expect(context.socket).to have_received(:puts).with('Your account has been created!'.colorize(:green))
      end
    end


    context 'with invalid inputs (missing email)' do
      before do
        allow(socket).to receive(:gets).and_return('', 'password', 'password')
      end

      it 'is expected to print an error message (Email can\'t be blank)' do
        expect(context.socket).to have_received(:puts).with('Email can\'t be blank'.colorize(:red))
      end
    end

    context 'with invalid inputs (duplicate email)' do
      before do
        create :account, email: 'foo@example.com'
        allow(socket).to receive(:gets).and_return('foo@example.com', 'password', 'password')
      end

      it 'is expected to print an error message (Name must exist)' do
        expect(context.socket).to have_received(:puts).with('Email has already been taken'.colorize(:red))
      end
    end

    context 'with invalid inputs (missing password)' do
      before do
        allow(socket).to receive(:gets).and_return('lucy', '', '')
      end

      it 'is expected to print an error message (Password can\'t be blank)' do
        expect(context.socket).to have_received(:puts).with('Password can\'t be blank'.colorize(:red))
      end
    end

    context 'with invalid inputs (wrong password confirmation)' do
      before do
        allow(socket).to receive(:gets).and_return('lucy', 'password', 'wrong')
      end

      it 'is expected to print an error message (Password confirmation doesn\'t match Password)' do
        expect(context.socket).to have_received(:puts).with('Password confirmation doesn\'t match Password'.colorize(:red))
      end
    end

  end
end
