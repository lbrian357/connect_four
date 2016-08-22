class Player
  attr_accessor :piece, :victory
  def initialize(piece)
    @piece = piece
    @victory = false
  end
end

class Game 
  attr_accessor :row1, :row2, :row3, :row4, :row5, :row6, :p1, :p2
  def initialize
    @row1 = "| | | | | | | |\n---------------\n"
    @row2 = "| | | | | | | |\n---------------\n"
    @row3 = "| | | | | | | |\n---------------\n"
    @row4 = "| | | | | | | |\n---------------\n"
    @row5 = "| | | | | | | |\n---------------\n"
    @row6 = "| | | | | | | |\n---------------\n"
    @p1 = Player.new('O')
    @p2 = Player.new('@')
  end

  def p_board
    puts "#{@row6}#{@row5}#{@row4}#{@row3}#{@row2}#{@row1}"
  end

  def find_col(col)
    case col
    when 1 
      1
    when 2
      3
    when 3
      5
    when 4
      7
    when 5
      9
    when 6
      11
    when 7
      13
    end
  end

  def target_col(col) #returns the row that has the next free slot
    row_ary = [row1, row2, row3, row4, row5, row6]
    i = 0
    condition = false
    while i < row_ary.length || condition == false
      if row_ary[i][find_col(col)] == ' '
        return row_ary[i]
        condition = true
      end
      i += 1
    end
  end

  def find_last_filled_col(col)
    row_ary = [row1, row2, row3, row4, row5, row6]
    i = 0
    condition = false
    while condition == false
      if i == row_ary.length 
        return row_ary[-1]
        condition = true
      elsif row_ary[i][find_col(col)] == ' '
        return row_ary[i-1]
        condition = true
      end
      i += 1
    end
  end

  def turn(col, player)
    target_col(col)[find_col(col)] = player.piece
  end

  def start
    count = 1
    p_board if count == 1
    while count <= 42 && p1.victory == false && p2.victory == false
      if count.odd? 
        puts 'Player 1 which column?'
        begin
          col = gets.chomp.to_i
          puts 'you can\'t do that, try again' if col < 1 || col > 7 || row6[find_col(col)] != ' '
        end while col < 1 || col > 7 || row6[find_col(col)] != ' '
        turn(col, p1) 
        win?(p1, col)

      else
        puts 'Player 2 which column?'
        begin
          col = gets.chomp.to_i
          puts 'you can\'t do that, try again' if col < 1 || col > 7
        end while col < 1 || col > 7 
        turn(col, p2)
        win?(p2, col)
      end
      p_board
      count += 1
    end
    if count == 43
      puts 'It\'s a draw'
    elsif p1.victory == true
      puts 'Player 1 wins'
    elsif p2.victory == true
      puts 'Player 2 wins'
    end
  end

  def horizontal_win(player)
    #four horizontal pieces the same
    #it brute forces by checking all possible cases
    row_ary = [row1, row2, row3, row4, row5, row6]
    row_ary.each do |row|
      base_ary = [1,2,3,4]
      until base_ary.include?(8)
        if row[find_col(base_ary[0])] == player.piece && row[find_col(base_ary[0])] == row[find_col(base_ary[1])] && row[find_col(base_ary[0])] == row[find_col(base_ary[2])] && row[find_col(base_ary[0])] == row[find_col(base_ary[3])] 
          player.victory = true
        end
        base_ary.map! { |n| n + 1 }
      end
    end
  end

  def vertical_win(col, player)
    row_ary = [row1, row2, row3, row4, row5, row6].reverse
    check_ary = []
    check_ary << row_ary.index(find_last_filled_col(col)) #finds highest piece in the column, presumably the one played this same turn
    check_ary << check_ary[0] + 1
    check_ary << check_ary[0] + 2
    check_ary << check_ary[0] + 3
    if check_ary.include?(6) #assures that method does not check for values outside the board
    else
      if row_ary[check_ary[0]][find_col(col)] == player.piece && row_ary[check_ary[0]][find_col(col)] == row_ary[check_ary[1]][find_col(col)] && row_ary[check_ary[0]][find_col(col)] == row_ary[check_ary[2]][find_col(col)] && row_ary[check_ary[0]][find_col(col)] == row_ary[check_ary[3]][find_col(col)]
        player.victory = true
      end
    end

  end

  def r_diag_win(player)
    row_ary = [row1, row2, row3, row4, row5, row6]
    col_n = [1, 2, 3, 4, 5, 6, 7]
    row_ary.each do |row|
      check_row = []
      check_row << row_ary.index(row)
      check_row << check_row[0] + 1
      check_row << check_row[0] + 2
      check_row << check_row[0] + 3
      col_n.each do |col|
        check_col = []
        check_col << col_n.index(col)
        check_col << check_col[0] + 1
        check_col << check_col[0] + 2
        check_col << check_col[0] + 3

        unless check_row.include?(6) || check_col.include?(7)
          player.victory = true if row_ary[check_row[0]][find_col(col_n[check_col[0]])] == player.piece && row_ary[check_row[0]][find_col(col_n[check_col[0]])] == row_ary[check_row[1]][find_col(col_n[check_col[1]])] && row_ary[check_row[0]][find_col(col_n[check_col[0]])] == row_ary[check_row[2]][find_col(col_n[check_col[2]])] && row_ary[check_row[0]][find_col(col_n[check_col[0]])] == row_ary[check_row[3]][find_col(col_n[check_col[3]])]
        end
      end
    end
  end

  def l_diag_win(player)
    row_ary = [row1, row2, row3, row4, row5, row6]
    col_n = [1, 2, 3, 4, 5, 6, 7].reverse
    row_ary.each do |row|
      check_row = []
      check_row << row_ary.index(row)
      check_row << check_row[0] + 1
      check_row << check_row[0] + 2
      check_row << check_row[0] + 3
      col_n.each do |col|
        check_col = []
        check_col << col_n.index(col)
        check_col << check_col[0] + 1
        check_col << check_col[0] + 2
        check_col << check_col[0] + 3

        unless check_row.include?(6) || check_col.include?(7)
          player.victory = true if row_ary[check_row[0]][find_col(col_n[check_col[0]])] == player.piece && row_ary[check_row[0]][find_col(col_n[check_col[0]])] == row_ary[check_row[1]][find_col(col_n[check_col[1]])] && row_ary[check_row[0]][find_col(col_n[check_col[0]])] == row_ary[check_row[2]][find_col(col_n[check_col[2]])] && row_ary[check_row[0]][find_col(col_n[check_col[0]])] == row_ary[check_row[3]][find_col(col_n[check_col[3]])]
        end
      end
    end
  end






  def win?(player, col = nil)
    if player.victory == false
      horizontal_win(player)
    end
    if player.victory == false && col != nil
      #vertical win
      vertical_win(col, player)
    end
    if player.victory == false
      r_diag_win(player)

    end
    if player.victory == false
      l_diag_win(player)

    end
  end
end

a = Game.new
a.start
