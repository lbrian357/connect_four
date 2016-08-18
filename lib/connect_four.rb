class Game 
  attr_accessor :row1, :row2, :row3, :row4, :row5, :row6, :row_ary
  def initialize
    @row1 = "| | | | | | | |\n---------------\n"
    @row2 = "| | | | | | | |\n---------------\n"
    @row3 = "| | | | | | | |\n---------------\n"
    @row4 = "| | | | | | | |\n---------------\n"
    @row5 = "| | | | | | | |\n---------------\n"
    @row6 = "| | | | | | | |\n---------------\n"
    @row_ary = [@row1, @row2, @row3, @row4, @row5, @row6]
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
    else
      puts 'not an option'
    end
  end

  def check_col(col)
    i = 0
    condition = false
    while i < row_ary.length || condition == false
      if row_ary[i][find_col(col)] == ' '
        return row_ary[i]
        #row_ary[i][find_col(col)] = 'O'
        condition = true
      end
      i += 1
=begin
      if i == row_ary.length
        puts 'you cannot do that, try again'
      end
=end
    end
    condition
  end

  def target_col(col)
    i = 0
    condition = false
    while i < @row_ary.length || condition == false
      if @row_ary[i][find_col(col)] == ' '
        return @row_ary.index(@row_ary[3])
        #row_ary[i][find_col(col)] = 'O'
        condition = true
      end
      i += 1
=begin
      if i == row_ary.length
        puts 'you cannot do that, try again'
      end
=end
    end
  end

  def turn(col)
    check_col(col)
  end
end

a = Game.new

a.p_board



