require 'connect_four'

describe 'Game' do
  before(:each) do
  @a_game = Game.new
  end

  describe '#p_board' do
    context "when game is #p_board is called" do
      it "will print out a 6x7 board" do
        expect{@a_game.p_board}.to output(

          "| | | | | | | |\n---------------\n| | | | | | | |\n---------------\n| | | | | | | |\n---------------\n| | | | | | | |\n---------------\n| | | | | | | |\n---------------\n| | | | | | | |\n---------------\n"
        ).to_stdout
      end
    end
  end

  describe '#find_col' do
    context 'when a column number 2 is entered by user' do
      it 'will refer to correct column 3 in string' do
        expect(@a_game.find_col(2)).to eql(3)
      end
    end

    context 'when column number 5 is entered' do
      it 'will refer to column 9 in string' do
        expect(@a_game.find_col(5)).to eql(9)
      end
    end
  end

  describe '#target_col' do
    context 'when a column number 1 is entered' do
      it 'will return the highest row number (2) that does not have a piece in it' do
        @a_game.row2 = "| |O| | | | | |\n---------------\n"
        @a_game.row1 = "|O|O| |O| | | |\n---------------\n"
        expect(@a_game.target_col(1)).to eql("| |O| | | | | |\n---------------\n")
      end
    end

    context 'when column 2 is entered' do
      it 'will return row3' do
        @a_game.row2 = "| |O| | | | | |\n---------------\n"
        @a_game.row1 = "|O|O| |O| | | |\n---------------\n"
        expect(@a_game.target_col(2)).to eql("| | | | | | | |\n---------------\n")
      end
    end
  end
=begin
  describe '#turn' do
    context 'when a column number is entered' do
      it 'will insert a piece at the bottom of the row' do
      end
    end
  end
=end
  #expect(@a_game.row1).to eql("|O| | | | | | |\n---------------\n")
end

