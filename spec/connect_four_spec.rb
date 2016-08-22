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
        @a_game.row3 = "| | |O| | | | |\n---------------\n"
        @a_game.row2 = "| |O|O| | | | |\n---------------\n"
        @a_game.row1 = "|O|O|O| | | | |\n---------------\n"
        expect(@a_game.target_col(1)).to eql("| |O|O| | | | |\n---------------\n")
      end
    end

    context 'when column 2 is entered' do
      it 'will return row3' do
        @a_game.row3 = "| | |O| | | | |\n---------------\n"
        @a_game.row2 = "| |O|O| | | | |\n---------------\n"
        @a_game.row1 = "|O|O|O| | | | |\n---------------\n"
        expect(@a_game.target_col(2)).to eql("| | |O| | | | |\n---------------\n")
      end
    end
  end

  describe '#turn' do
    context 'when a column number is entered' do
      it 'will insert a piece at the bottom-most empty row' do
        @a_game.row1 = "|O|O|O| | | | |\n---------------\n"
        @a_game.turn(3, @a_game.p1)
        expect(@a_game.row2).to eql("| | |O| | | | |\n---------------\n")
      end
    end

    context 'when a column number is entered' do
      it ' will insert a piece at the top row if all others in the column is filled' do
        @a_game.row6 = "| | | | | | | |\n---------------\n"
        @a_game.row5 = "| | |O| | | | |\n---------------\n"
        @a_game.row4 = "| | |O| | | | |\n---------------\n"
        @a_game.row3 = "| | |O| | | | |\n---------------\n"
        @a_game.row2 = "| | |O| | | | |\n---------------\n"
        @a_game.row1 = "| | |O| | | | |\n---------------\n"

        @a_game.turn(3, @a_game.p1)
        expect(@a_game.row6).to eql("| | |O| | | | |\n---------------\n")
      end
    end
  end

  describe '#p1' do
    context 'when a Game is initialized' do
      it 'will create a player and assign them playing pieces' do
        expect(@a_game.p1.piece).to eql("O")
      end
    end
  end

  describe '#p2' do
    context 'when Game is initialized' do
      it 'will create another player and assign them playing pieces' do
        expect(@a_game.p2.piece).to eql("@")
      end
    end
  end

  describe '#find_last_filled_col' do
    context 'when given a column number' do
      it 'returns that last row with a piece in it' do
        @a_game.row6 = "|O| | | | | | |\n---------------\n"
        @a_game.row5 = "|O|O| | | | | |\n---------------\n"
        @a_game.row4 = "|O|O|O| | | | |\n---------------\n"
        @a_game.row3 = "|O|O|O|O| | | |\n---------------\n"
        @a_game.row2 = "|O|O|O|O| | | |\n---------------\n"
        @a_game.row1 = "|O|O|O|O| | | |\n---------------\n"
        expect(@a_game.find_last_filled_col(2)).to equal(@a_game.row5)
      end

      it 'returns the last row' do 
        @a_game.row6 = "|O| | | | | | |\n---------------\n"
        @a_game.row5 = "|O|O| | | | | |\n---------------\n"
        @a_game.row4 = "|O|O|O| | | | |\n---------------\n"
        @a_game.row3 = "|O|O|O|O| | | |\n---------------\n"
        @a_game.row2 = "|O|O|O|O| | | |\n---------------\n"
        @a_game.row1 = "|O|O|O|O| | | |\n---------------\n"
        expect(@a_game.find_last_filled_col(1)).to equal(@a_game.row6)
      end
    end
  end


  describe '#win?' do
    context 'when there are four pieces in a horizontal row' do
      it 'changes that player\'s victory to true' do
        @a_game.row1 = "|O|O|O|O| | | |\n---------------\n"
        @a_game.win?(@a_game.p1)
        expect(@a_game.p1.victory).to eql(true)
      end

      it 'also works for row6' do
        @a_game.row6 = "| | | |@|@|@|@|\n---------------\n"
        @a_game.win?(@a_game.p2)
        expect(@a_game.p2.victory).to eql(true)
      end
    end

    context 'when there are no cases which match' do
      it 'victory condition remains false' do
        @a_game.row1 = "| |O| | | | | |\n---------------\n"
        @a_game.win?(@a_game.p1, 2)
        expect(@a_game.p1.victory).to eql(false)
      end
    end

    context 'when there are four verticles' do
      it 'makes victory condition true for the player' do
        @a_game.row4 = "| | | | | | | |\n---------------\n"
        @a_game.row3 = "| |O| | | | | |\n---------------\n"
        @a_game.row2 = "| |O| | | | | |\n---------------\n"
        @a_game.row1 = "| |O| | | | | |\n---------------\n"
        @a_game.turn(2, @a_game.p1)
        @a_game.win?(@a_game.p1, 2)

        expect(@a_game.p1.victory).to eql(true)
      end
    end

    context 'when there are four verticles at the very top' do
      it 'makes victory condition true for the player' do
        @a_game.row6 = "| | | | | | | |\n---------------\n"
        @a_game.row5 = "| |O| | | | | |\n---------------\n"
        @a_game.row4 = "| |O| | | | | |\n---------------\n"
        @a_game.row3 = "| |O| | | | | |\n---------------\n"
        @a_game.row2 = "| |@| | | | | |\n---------------\n"
        @a_game.row1 = "| |@| | | | | |\n---------------\n"
        @a_game.turn(2, @a_game.p1)

        @a_game.win?(@a_game.p1, 2)

        expect(@a_game.p1.victory).to eql(true)
      end
    end

    context 'when there are four diagonals going towards the top right' do
      it 'makes victory ondition true for that player' do
        @a_game.row4 = "| |@| |O| | | |\n---------------\n"
        @a_game.row3 = "| |@|O| | | | |\n---------------\n"
        @a_game.row2 = "| |O| | | | | |\n---------------\n"
        @a_game.row1 = "|O|@| | | | | |\n---------------\n"
        @a_game.win?(@a_game.p1)
        expect(@a_game.p1.victory).to eql(true)
      end
    end

    context 'when diagonal starts in the middle of the grid' do
      it 'makes victory condition true for that player' do
        @a_game.row6 = "| |@| |O| |@| |\n---------------\n"
        @a_game.row5 = "| |@| |O|@| | |\n---------------\n"
        @a_game.row4 = "| |@| |@| | | |\n---------------\n"
        @a_game.row3 = "| | |@|O| | | |\n---------------\n"
        @a_game.win?(@a_game.p2)
        expect(@a_game.p2.victory).to eql(true)
      end
    end

    context 'when diagonal starts from bottom right to top left' do
      it 'makes players victory condition true' do
        @a_game.row4 = "| | | |O| |@| |\n---------------\n"
        @a_game.row3 = "| |@| | |O|@| |\n---------------\n"
        @a_game.row2 = "| |@| | | |O| |\n---------------\n"
        @a_game.row1 = "| |@| | | |@|O|\n---------------\n"
        @a_game.win?(@a_game.p1)
        expect(@a_game.p1.victory).to eql(true)
      end
    end

    context 'when diagonal appears at top left corner of grid' do
      it 'makes players victory condition true' do
        @a_game.row6 = "|@| | | | |@| |\n---------------\n"
        @a_game.row5 = "| |@| |O| | | |\n---------------\n"
        @a_game.row4 = "| | |@| | |@| |\n---------------\n"
        @a_game.row3 = "| | | |@| |@| |\n---------------\n"
        @a_game.win?(@a_game.p2)
        expect(@a_game.p2.victory).to eql(true)
      end
    end
  end
=begin
  describe '#start' do
    context 'when a game is started' do
      it 'will alternating between player\'s turns up to 42 times' do
        expect(@a_game.start).to eql(
=end

end

