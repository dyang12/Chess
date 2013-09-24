require './chess.rb'

module SteppingPieces

end

class King < Piece
  attr_reader :display

  def initialize(color, initial_pos)
    super(color, initial_pos)
    @display_type = "K"
  end

  def poss_moves(board)
    poss_moves = []

    (curr_pos[0]-1..curr_pos[0]+1).each do |row|
      (curr_pos[1]-1..curr_pos[1]+1).each do |col|
        pos = [row, col]
        poss_moves << pos unless board.out_of_bounds?(pos)
      end
    end
    poss_moves.reject! do |pos|
      !board[pos].nil? && board[pos].color == color
    end
    poss_moves
  end

end

class Knight < Piece
  attr_reader :display

  def initialize(color, initial_pos)
    super(color, initial_pos)
    @display_type = "N"
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

end
