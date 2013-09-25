require 'colorize'

class Board
  attr_reader :board

  def initialize
    create_board
    set_pieces
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
          row_string += "#{render_piece(el)} "
        end
      end
      puts row_string.chomp
    end
  end

  def render_piece(piece)
      return piece.display_type.white if piece.color == :white
      return piece.display_type.red
  end

  def set_pieces
    8.times do |col|
      b_pawn = Pawn.new(:black, [1, col])
      board[1][col] = b_pawn
    end

    [0, 7].each do |col|
      b_rook = Rook.new(:black, [0, col])
      board[0][col] = b_rook
    end

    [1, 6].each do |col|
      b_knight = Knight.new(:black, [0, col])
      board[0][col] = b_knight
    end

    [2, 5].each do |col|
      b_bishop = Bishop.new(:black, [0, col])
      board[0][col] = b_bishop
    end

    b_queen = Queen.new(:black, [0,3])
    board[0][3] = b_queen

    b_king = King.new(:black, [0, 4])
    board[0][4] = b_king

    8.times do |col|
      w_pawn = Pawn.new(:white, [6, col])
      board[6][col] = w_pawn
    end

    [0, 7].each do |col|
      w_rook = Rook.new(:white, [7, col])
      board[7][col] = w_rook
    end

    [1, 6].each do |col|
      w_knight = Knight.new(:white, [7, col])
      board[7][col] = w_knight
    end

    [2, 5].each do |col|
      w_bishop = Bishop.new(:white, [7, col])
      board[7][col] = w_bishop
    end

    w_queen = Queen.new(:white, [7,3])
    board[7][3] = w_queen

    w_king = King.new(:white, [7, 4])
    board[7][4] = w_king
  end

  def valid_moves(pos)
    #clone the board and make suggested move
    #cloned_board.checked?
    #if true, set board = cloned_board

  end

  def dup
    #clone board
  end

  def checked?(color)
    king_pos = find_king_pos(color)
    opposing_pieces = find_opposing_pieces(color)

    opposing_pieces.each do |piece|
      return true if piece.poss_moves(self).include?(king_pos)
    end

    return false
  end

  def find_king_pos(color)
    (0...8).each do |row|
      (0...8).each do |col|
        if board[row][col].is_a?(King) && board[row][col].color == color
          return [row, col]
        end
      end
    end
  end

  def find_opposing_pieces(color)
    opposing_pieces = []
    (0...8).each do |row|
      (0...8).each do |col|
        unless board[row][col].nil? || board[row][col].color == color
          opposing_pieces << board[row][col]
        end
      end
    end

    opposing_pieces
  end


  def move_piece(end_pos)
    curr_pos = end_pos
    #remove previous residing piece if killed
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

  def poss_move(curr_pos)
    #returns every valid move that a piece can make without checking for it
    #
  end

  def remove_allies(board, poss_moves)
    poss_moves.reject! do |pos|
      !board[pos].nil? && board[pos].color == color
    end
    poss_moves
  end

  def add_positions(delta)
    dx, dy = delta
    [curr_pos[0]+dx, curr_pos[1]+dy]
  end
end

class Chess

end

class HumanPlayer

end