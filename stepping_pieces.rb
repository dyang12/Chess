module SteppingPieces
  def move_piece(end_pos)

  end
end

class King < Piece
  attr_reader :display

  def initialize(color, initial_pos)
    super (color,initial_pos)
    @display = "K"
  end
end

class Knight < Piece
  attr_reader :display

  def initialize(color, initial_pos)
    super (color,initial_pos)
    @display = "N"
  end
end
