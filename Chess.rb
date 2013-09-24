class Board
  attr_reader :board

  def initialize
    create_board
    # set_pieces(:white)
    # set_pieces(:black)
  end

  def create_board
    @board = Array.new(8) { Array.new(8) }
  end

  def display_board
    puts "  0 1 2 3 4 5 6 7"
    board.each_with_index do |row, i|
      row_string = "#{i} "
      row.each do |el|
        if el.nil?
          row_string += "_ "
        else
          row_string += "#{el.display_type} "
        end
      end
      puts row_string.chomp
    end
  end

  def set_pieces(color)
    #initializes and set all the pieces of a specific color
  end

  def []=(pos, piece)
    row, col = pos
    @board[row][col] = piece
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def out_of_bounds?(pos)
    return true if pos[0] < 0 || pos[0] > 7 || pos[1] < 0 || pos[1] > 7
    false
  end
end

class Piece
  attr_accessor :curr_pos
  attr_reader :color

  def initialize(color, initial_pos)
    @color = color
    @curr_pos = initial_pos
  end

  def valid_move?(pos)
    #write throwexception to see if we did not implement valid move for each class
    #uses poss_move to check whether a piece can move to that location
    #check)
  end

  def poss_move(curr_pos)
    #returns every valid move that a piece can make without checking for it
    #
  end

  def move_piece(end_pos)
    curr_pos = end_pos
    #remove previous residing piece if killed
  end

  def remove_allies(board, poss_moves)
    poss_moves.reject! do |pos|
      !board[pos].nil? && board[pos].color == color
    end
  end
end

class Chess

end

class HumanPlayer

end