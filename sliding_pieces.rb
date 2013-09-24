module SlidingPieces
  def move

  end
end

class Queen < Piece
  attr_reader :display

  def initialize(color, initial_pos)
    super (color,initial_pos)
    @display = "Q"
  end
end


class Rook < Queen
  def initialize(color, initial_pos)
    super (color,initial_pos)
    @display = "R"
  end
end


class Bishop < Queen
  def initialize(color, initial_pos)
    super (color,initial_pos)
    @display = "B"
  end
end
