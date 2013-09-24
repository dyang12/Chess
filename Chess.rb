class Board
  attr_reader :board

  def initialize
    create_board
    set_pieces(:white)
    set_pieces(:black)
  end

  def create_board
    @board = Array.new(8) { Array.new(8) }
  end

  def set_pieces(color)
    #initializes and set all the pieces of a specific color
  end
end

class Piece
  attr_accessor :curr_pos
  attr_reader :color

  def initialize(color, initial_pos)
    @color = color
    @curr_pos = initial_pos
  end

end

class Chess

end

class HumanPlayer

end