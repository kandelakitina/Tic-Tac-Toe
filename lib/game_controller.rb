# frozen_string_literal: true

require_relative 'board'
require_relative 'human_player'
require_relative 'ai_player'

# GameController manages the game loop and orchestrates player turns and board updates.
class GameController
  def initialize
    @board = Board.new
    @players = {
      X: HumanPlayer.new(:X),
      O: AIPlayer.new(:O)
    }
    @current_mark = :X
  end

  def play
    until game_over?
      @board.display
      row, col = current_player.move(@board)
      @board.place_mark(row, col, @current_mark)
      switch_player unless game_over?
    end

    @board.display
    if @board.winner
      puts "Player #{@board.winner} wins!"
    else
      puts "It's a draw!"
    end
  end

  private

  def current_player
    @players[@current_mark]
  end

  def switch_player
    @current_mark = @current_mark == :X ? :O : :X
  end

  def game_over?
    @board.winner || @board.full?
  end
end

