# frozen_string_literal: true

# The Player class represents a player in the Tic-Tac-Toe game.
# Can be either AIPlayer or HumanPlayer
class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
end
