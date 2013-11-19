Chess
=====
Chess- Defines the turn by turn gameplay of chess and alternates between human players.  Makes sure that each move is valid before allowing the user to make move.  Re-prompts player if the move is invalid in any way.
Board- Sets the boundaries of the board and initial position of all pieces.  During the course of the game, the board keeps track of the position of every piece as well as occurences of check and checkmate.
Piece- Parent class for all pieces, defines all methods that apply to every piece; such as color, current position, and valid moves
HumanPlayer- Defines ui methods that prompt user for what piece he would like to move and where he would like to move it.

SlidingPiece Module- Included within the class of any pieces that are defined as sliding and finds all possible moves using the predefined deltas of each piece.
 * Queen
 * Rook
 * Bishop
 
SteppingPiece Module- Included within the class of any pieces that are defined as stepping and finds all possible moves using the predefined deltas of each piece
 * King
 * Knight
 * Pawn- special case of SteppingPiece, poss_moves method had to be overwritten to account for a pawns initial move as well as capturing rules.

Use of SlidingPiece and SteppingPiece modules created very DRY code, poss_moves method did not have to be repeated in pieces that adhered to the same move restrictions.
