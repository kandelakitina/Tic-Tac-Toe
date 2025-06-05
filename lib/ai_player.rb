# frozen_string_literal: true

require_relative 'player'

# AIPlayer represents a computer-controlled player in the game.
class AIPlayer < Player
  def initialize(mark)
    super(mark, type: :ai)
  end

  def move(board)
    sleep 0.5 # simulate "thinking" delay
    choice = board.empty_positions.sample
    puts "AI (#{mark}) chooses row #{choice[0]}, column #{choice[1]}"
    choice
  end
end
