require './Chess.rb'

module SteppingPiece
  def poss_moves(board)
    poss_moves = @deltas.map do |delta|
      add_positions(delta)
    end
    poss_moves.reject! {|pos| board.out_of_bounds?(pos)}
    remove_allies(board, poss_moves)
  end

  def remove_allies(board, poss_moves)
    poss_moves.reject! do |pos|
      !board[pos].nil? && board[pos].color == color
    end
    poss_moves
  end
end

class King < Piece
  attr_reader :display_type
  include SteppingPiece

  def initialize(color, initial_pos)
    super(color, initial_pos)
    @display_type = "K"
    @deltas = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
  end
end

class Knight < Piece
  attr_reader :display_type
  include SteppingPiece

  def initialize(color, initial_pos)
    super(color, initial_pos)
    @display_type = "N"
    @deltas = [[1,2],[1,-2],[2,1],[2,-1],[-1,-2],[-1,2],[-2,-1],[-2,1]]
  end
end


class Pawn < Piece
  attr_accessor :first_move
  attr_reader :display_type

  def initialize(color, initial_pos)
    super(color, initial_pos)
    @display_type = "P"
    @first_move = true
  end


  def poss_moves(board)
    color == :white ? num = -1 : num = 1
    poss_moves = add_diag_moves(board, num)
    poss_moves.concat(add_forward_moves(board, num))
  end

  def add_diag_moves(board, num)
    diag_moves = []
    (curr_pos[1]-1..curr_pos[1]+1).each do |col|
      next if col == 0
      pos = [curr_pos[0] + num, col]
      unless board.out_of_bounds?(pos)
        diag_moves << pos if has_enemy?(board,pos)
      end
    end
    diag_moves
  end

  def add_forward_moves(board, num)
    forward_moves = []
    pos = [curr_pos[0]+num, curr_pos[1]]
    if !board.out_of_bounds?(pos) && board[pos].nil?
      forward_moves << pos
      if @first_move
        new_pos = [pos[0]+num, pos[1]]
        forward_moves << new_pos if board[pos].nil?
      end
    end
    forward_moves
  end

  def has_enemy?(board,pos)
    return true unless board[pos].nil? || board[pos].color == color
    false
  end
end











