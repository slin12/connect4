require 'pry'

class ConnectFour

  def initialize
    @board = [
    [" ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " "]
    ]

    @turn_count = 0
    @position = []
    display_board
    game
  end


  def game
    loop do
      take_turn
      if win?
        puts "#{whos_turn} wins!"
        break
      end
    end
  end

  def display_board
    for i in 0..@board.length - 1
      for j in 0..@board[0].length - 1
        print "| #{@board[i][j]} "
      end
      print "|"
      puts "\n"
    end
  end

  def get_user_column #asks user for column
    puts "It's #{@turn_count.even? ? marker = "X" : marker = "O"}'s turn!"
    puts "Which column would you like to play? (1-7)"
    answer = gets.chomp
  end

  def place_marker(marker, column)
    column -= 1 #starts at index 0
    x = @board.length - 1
    until @board[x][column] == " "
      x -= 1
    end
    @board[x][column] = marker
    [x, column]
  end

  def play_move(marker)
    column = 0
    until column > 0 && column < 8
      column = get_user_column.to_i
    end
    @position = place_marker(marker, column)
  end

  def whos_turn
    @turn_count.even? ? marker = "O" : marker = "X"
  end

  def take_turn
    marker = @turn_count.even? ? marker = "X" : marker = "O"
    play_move(marker)
    puts "Here's the current board:"
    display_board
    @turn_count += 1
  end

  def win?
    horizontal || vertical || left_diagonal || right_diagonal
  end

  #checks if there's a horizontal win w/ passed in position
  def horizontal #position comes in an array like [1, 1]
    row = @position[0]
    column = @board[row].join("")
    column.include?("XXXX") || column.include?("OOOO") #true or false
  end

  #checks if there's a vertical win
  def vertical
    column_idx = @position[1]
    column = ""
    for i in 0...@board.length
      column << @board[i][column_idx]
    end
    column.include?("XXXX") || column.include?("OOOO") #true or false
  end

  def left_diagonal #say, [3, 2]
    upleft = [@position[0], @position[1]]
    downright = [@position[0] + 1, @position[1] + 1]
    string = ""
    until upleft[0] < 0 || upleft[1] < 0
      string += @board[upleft[0]][upleft[1]]
      upleft[0] -= 1
      upleft[1] -= 1
    end
    until downright[0] > 5 || downright[1] > 6
      string += @board[downright[0]][downright[1]]
      downright[0] += 1
      downright[1] += 1
    end
    string.count("X") == 4 || string.count("X") == 4
  end

  def right_diagonal #say, [3, 2]
    upright = [@position[0], @position[1]]
    downleft = [@position[0] + 1, @position[1] - 1]
    string = ""
    until upright[0] < 0 || upright[1] > 6
      string += @board[upright[0]][upright[1]]
      upright[0] -= 1
      upright[1] += 1
    end
    until downleft[0] > 5 || downleft[1] < 0
      string += @board[downleft[0]][downleft[1]]
      downleft[0] += 1
      downleft[1] -= 1
    end
    string.count("X") == 4 || string.count("O") == 4
  end

end
