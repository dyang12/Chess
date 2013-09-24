require './chess.rb'

module SlidingPieces

end

class Queen < Piece
  attr_reader :display

  def initialize(color, initial_pos)
    super(color,initial_pos)
    @display_type = "Q"
  end

end


class Rook < Piece
  def initialize(color, initial_pos)
    super(color,initial_pos)
    @display_type = "R"
  end
end


class Bishop < Piece
  def initialize(color, initial_pos)
    super(color,initial_pos)
    @display_type = "B"
  end
end
