require 'colorize'

class Board
  attr_accessor :board

  def initialize
    create_board
    set_pieces
  end

  def create_board
    @board = Array.new(8) { Array.new(8) }
  end

  def display_board
    puts "   0 1 2 3 4 5 6 7"
    board.each_with_index do |row, i|
      row_string = "#{i} "
      row.each do |el|
        if el.nil?
          row_string += "|_"
        else
          row_string += "|#{render_piece(el).underline}"
        end
      end
      puts row_string + "|"
    end
  end

  def move(start_pos, end_pos, color)
    moving_obj = self[start_pos]

    if moving_obj.color != color
      raise ArgumentError.new "That's not your piece"
    else
      poss_moves = moving_obj.poss_moves(self)
      valid_moves = moving_obj.valid_moves(self,poss_moves)

      if valid_moves.include?(end_pos)
        self[start_pos] = nil
        moving_obj.curr_pos = end_pos
        moving_obj.first_move = false if moving_obj.is_a?(Pawn)
        self[end_pos] = moving_obj
      else
        raise ArgumentError.new "Invalid Move"
      end
    end
  end

  def dup
    new_board = Board.new
    new_board.board = dup_board
    return new_board
  end

  def checked?(color)
    king_pos = find_king_pos(color)
    opposing_pieces = find_all_pieces(color).select do |piece|
      piece.color != color
    end

    opposing_pieces.each do |enemy|
      return true if enemy.poss_moves(self).include?(king_pos)
    end

    return false
  end

  def checkmate?(color)
    if checked?(color)
      ally_pieces = find_all_pieces(color).select do |piece|
        piece.color == color
      end
      ally_pieces.each do |ally|
        poss_moves = ally.poss_moves(self)
        valid_moves = ally.valid_moves(self,poss_moves)

        return false if valid_moves.length > 0
      end
    else
      return false
    end

    return true
  end

  def out_of_bounds?(pos)
    return true if pos[0] < 0 || pos[0] > 7 || pos[1] < 0 || pos[1] > 7
    false
  end

  def []=(pos, piece)
    row, col = pos
    @board[row][col] = piece
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  private

  def dup_board
    dup_board = []
    board.each do |row|
      dup_row = []
      row.each do |el|
        if el.nil?
          dup_row << nil
        else
          dup_piece = el
          dup_row << dup_piece
        end
      end
      dup_board << dup_row
    end
    dup_board
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

  def find_king_pos(color)
    (0...8).each do |row|
      (0...8).each do |col|
        if board[row][col].is_a?(King) && board[row][col].color == color
          return [row, col]
        end
      end
    end
  end

  def find_all_pieces(color)
    all_pieces = []
    (0...8).each do |row|
      (0...8).each do |col|
        unless board[row][col].nil?
          all_pieces << board[row][col]
        end
      end
    end
    all_pieces
  end
end

class Piece
  #refactor valid moves array into instance variable
  attr_accessor :curr_pos
  attr_reader :color

  def initialize(color, initial_pos)
    @color = color
    @curr_pos = initial_pos
  end

  def valid_moves(board, poss_moves)
    valid_moves = []
    poss_moves = poss_moves(board)
    poss_moves.each do |pos|
      valid_moves << pos unless move_into_check?(board, pos)
    end

    p valid_moves
  end

  def poss_moves(curr_pos)

  end

  def add_positions(delta)
    dx, dy = delta
    [curr_pos[0]+dx, curr_pos[1]+dy]
  end

  private

  def move_into_check?(board, pos)
    temp_board = board.dup
    temp_board[curr_pos] = nil
    curr_pos = pos
    temp_board[curr_pos] = self

    return temp_board.checked?(color)
  end
end

class Chess
  def initialize
    play
  end

  def play
    b = Board.new

    player1 = HumanPlayer.new(:white)
    player2 = HumanPlayer.new(:black)

    loop do
      if b.checkmate?(player1.color)
        puts "Player 2 Wins!"
        quit
      else
        if b.checked?(player1.color)
          puts "Player1, you are in check."
        end
        b.display_board

        begin
          start_pos, end_pos = player1.prompt_for_move
          b.move(start_pos, end_pos, player1.color)
        rescue ArgumentError => e
          puts "#{e.message}"
          retry
        end
      end

      if b.checkmate?(player2.color)
        puts "Player 2 Wins!"
        quit
      else
        if b.checked?(player2.color)
          puts "Player1, you are in check."
        end
        b.display_board

        begin
          start_pos, end_pos = player2.prompt_for_move
          b.move(start_pos, end_pos, player2.color)
        rescue ArgumentError => e
          puts "#{e.message}"
          retry
        end
      end
    end
  end
end

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def prompt_for_move
    puts "What is the position of the piece would you like to move?"
    start_pos = input_to_array(gets.chomp)

    puts "What position would you like to move the piece to?"
    end_pos = input_to_array(gets.chomp)
    [start_pos, end_pos]
  end

  def input_to_array(str)
    x = str[0].to_i
    y = str[-1].to_i
    [x, y]
  end
end