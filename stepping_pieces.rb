require './chess.rb'

module SteppingPieces

end

class King < Piece
  attr_reader :display_type

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
    remove_allies(board, poss_moves)
  end
end

class Knight < Piece
  attr_reader :display_type

  def initialize(color, initial_pos)
    super(color, initial_pos)
    @display_type = "N"
  end

  def poss_moves(board)
    deltas = [[1,2],[1,-2],[2,1],[2,-1],[-1,-2],[-1,2],[-2,-1],[-2,1]]

    poss_moves = deltas.map do |(dx, dy)|
      [curr_pos[0]+dx, curr_pos[1]+dy]
    end
    poss_moves.reject! {|pos| board.out_of_bounds?(pos)}
    p poss_moves
    remove_allies(board, poss_moves)
  end
end
