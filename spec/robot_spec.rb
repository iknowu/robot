require 'spec_helper'

describe Robot do
  before(:each) do
    @r=Robot.new
  end

  describe 'maneuver' do

    describe 'validate before action' do
      it 'should validate before move' do
        expect(@r).to receive(:is_valid?).once
        @r.move
      end

      it 'should validate before place' do
        expect(@r).to receive(:is_valid?).once
        @r.right
      end

      it 'should validate before turn right' do
        expect(@r).to receive(:is_valid?).once
        @r.left
      end

      it 'should validate before turn left' do
        expect(@r).to receive(:is_valid?).once
        @r.place 1, 1, 'NORTH'
      end
    end

    describe 'place' do
      it 'can place at a valid position' do
        @r.place 1, 1, 'WEST'
        expect(@r.current_post).to eq('1,1,WEST')
      end

      it 'should ignore out of bound new position' do
        @r.place 6, 1, 'NORTH'
        expect(@r.current_post).to eq('-1,-1,NORTH')
      end
    end


    describe 'move' do
      it 'should be able to move toward North' do
        @r.place 2, 2, 'NORTH'
        @r.move
        expect(@r.current_post).to eq('2,3,NORTH')
      end

      it 'should be able to move toward West' do
        @r.place 2, 2, 'WEST'
        @r.move
        expect(@r.current_post).to eq('1,2,WEST')
      end

      it 'should be able to move toward East' do
        @r.place 2, 2, 'EAST'
        @r.move
        expect(@r.current_post).to eq('3,2,EAST')
      end

      it 'should be able to move toward South' do
        @r.place 2, 2, 'SOUTH'
        @r.move
        expect(@r.current_post).to eq('2,1,SOUTH')
      end

      describe 'cause it to fall' do
        it 'stops facing North' do
          @r.place 5, 5, 'NORTH'
          @r.move
          expect(@r.current_post).to eq('5,5,NORTH')
        end

        it 'stops facing South' do
          @r.place 5, 0, 'SOUTH'
          @r.move
          expect(@r.current_post).to eq('5,0,SOUTH')
        end

        it 'stops facing West' do
          @r.place 0, 5, 'WEST'
          @r.move
          expect(@r.current_post).to eq('0,5,WEST')
        end

        it 'stops facing East' do
          @r.place 5, 5, 'EAST'
          @r.move
          expect(@r.current_post).to eq('5,5,EAST')
        end
      end

    end

    describe 'turn right' do
      it 'turn right when facing North' do
        @r.place 1, 1, 'NORTH'
        @r.right
        expect(@r.facing).to eq('EAST')
      end

      it 'turn right when facing South' do
        @r.place 1, 1, 'SOUTH'
        @r.right
        expect(@r.facing).to eq('WEST')
      end

      it 'turn right when facing West' do
        @r.place 1, 1, 'WEST'
        @r.right
        expect(@r.facing).to eq('NORTH')
      end

      it 'turn right when facing East' do
        @r.place 1, 1, 'EAST'
        @r.right
        expect(@r.facing).to eq('SOUTH')
      end
    end
  end

  describe 'execute command' do
    it 'should validate command line first' do
      expect(@r).not_to receive(:move)
      @r.execute 'move1'
    end

    it 'move correctly' do
      expect(@r).to receive(:move).once.with(no_args())
      @r.execute 'move'
    end

    it 'turn right correctly' do
      expect(@r).to receive(:right).once.with(no_args())
      @r.execute 'right'
    end

    it 'turn left correctly' do
      expect(@r).to receive(:left).once.with(no_args())
      @r.execute 'left'
    end

    it 'report correctly' do
      expect(@r).to receive(:report).once.with(no_args())
      @r.execute 'report'
    end

    it 'place correctly' do
      expect(@r).to receive(:place).once.with('1', '1', 'NORTH')
      @r.execute 'place 1,1,NORTH'
    end

    it 'should also accept uppercase command' do
      expect(@r).to receive(:report).once.with(no_args())
      @r.execute 'REPORT'
    end
  end

  describe 'command line regex' do
    it 'should be true for valid command' do
      expect('move'=~Robot::COMMAND_REGEX).not_to be_nil
      expect('right'=~Robot::COMMAND_REGEX).not_to be_nil
      expect('left'=~Robot::COMMAND_REGEX).not_to be_nil
      expect('report'=~Robot::COMMAND_REGEX).not_to be_nil
      expect('place 1,1,south'=~Robot::COMMAND_REGEX).not_to be_nil
    end

    it 'should be false if the command is invalid' do
      expect('1move'=~Robot::COMMAND_REGEX).to be_nil
      expect('right1'=~Robot::COMMAND_REGEX).to be_nil
      expect('left 1'=~Robot::COMMAND_REGEX).to be_nil
      expect('report 1'=~Robot::COMMAND_REGEX).to be_nil
      expect('place 6,-1,north'=~Robot::COMMAND_REGEX).to be_nil
    end
  end
end
