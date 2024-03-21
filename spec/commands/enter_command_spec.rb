# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnterCommand do
  let!(:socket) { instance_double(TCPSocket) }
  let!(:session) { GameSession.new(socket) }
  
  before do
    allow(socket).to receive(:puts)
  end

  describe '#run' do
    context "without a current account" do

      before do
        described_class.new('foo', session).run
      end

      it 'is expected to show the user a warning message (account required)' do
        expect(socket).to have_received(:puts).with(BaseCommand::ACCOUNT_REQUIRED.colorize(:yellow))
      end
    end

    context "with a current account" do
      let!(:account) { create(:account) }

      before do
        session.account = account
      end

      context "without a current character" do
  
        before do
          described_class.new('foo', session).run
        end
  
        it 'is expected to show the user a warning message (character required)' do
          expect(socket).to have_received(:puts).with(BaseCommand::CHARACTER_REQUIRED.colorize(:yellow))
        end
      end

      context "with a current character" do
        let!(:character) { create(:character, account: account) }

        before do
          session.character = character
        end
  
        context "with an empty dungeon" do
          let!(:dungeon) { create(:dungeon, account: account) }
  
          before do
            described_class.new(dungeon.name, session).run
          end
    
          it 'is expected to show the user a warning message (no position required)' do
            expect(socket).to have_received(:puts).with(EnterCommand::ROOM_REQUIRED.colorize(:yellow))
          end
        end

        context "with a valid dungeon" do
          let!(:dungeon) { create(:dungeon, account: account) }
          let!(:room) { create(:room, dungeon: dungeon, account: account) }        

          context "with a current character's position" do
            let!(:character_position) { create(:character_position, account: account, character: character, dungeon: dungeon, room: room) }
    
            before do
              described_class.new(dungeon.name, session).run
            end
      
            it 'is expected to show the user a warning message (no position required)' do
              expect(socket).to have_received(:puts).with(BaseCommand::NO_POSITION_REQUIRED.colorize(:yellow))
            end
          end

          context "without a current character's position" do
    
            before do
              described_class.new(dungeon.name, session).run
            end
      
            it 'is expected to create the character\'s position' do
              expect(character.position).to_not be_nil 
            end

            it 'is expected to assign the dungeon to the character\'s position' do
              expect(character.position.dungeon).to eq(dungeon)
            end

            it 'is expected to assign the room to the character\'s position' do
              expect(character.position.room).to eq(room)
            end

            it 'is expected to print a success message' do
              expect(socket).to have_received(:puts).with("You have entered the #{dungeon.name} dungeon. Good luck!".colorize(:green))
            end
          end


        end
  
      end
      

    end


    # context 'with no arguments' do

    #   before do
    #     described_class.new('', session).run
    #   end

    #   it 'is expected to show the user an error message (invalid argument)' do
    #     expect(socket).to have_received(:puts).with("Invalid argument: <empty>".colorize(:red))
    #   end
    # end

    # context 'with an invalid argument' do

    #   before do
    #     described_class.new('foo', session).run
    #   end

    #   it 'is expected to show the user an error message (invalid argument)' do
    #     expect(socket).to have_received(:puts).with("Invalid argument: foo".colorize(:red))
    #   end
    # end

    # context "with a valid argument (existing character's name)" do

    #   let!!(:character) { create :character, account: account, name: "Lucy"}

    #   before do
    #     described_class.new("Lucy", session).run
    #   end

    #   it 'is expected to change game character' do
    #     expect(session.character).to eq(character)
    #   end

    #   it 'is expected to print a success message' do
    #     expect(socket).to have_received(:puts).with("You are now playing as Lucy.".colorize(:green))
    #   end



    # end
  
  end
end
