# frozen_string_literal: true

require_relative 'player'

# HumanPlayer represents a human-controlled player in the game.
class HumanPlayer < Player
  def initialize(mark)
    super(mark, type: :human)
  end

  def move(board)
    row, col = nil, nil

    loop do
      puts "Player #{mark}, enter your move."
      row = prompt_coordinate('row')
      col = prompt_coordinate('column')

      break if board.valid_move?(row, col)

      puts 'Invalid move. That spot is taken or out of bounds.'
    end

    [row, col]
  end

  private

  def prompt_coordinate(axis)
    loop do
      print "Enter #{axis} (0, 1, or 2): "
      input = gets.chomp
      return input.to_i if input.match?(/^[0-2]$/)

      puts "Invalid #{axis}. Please enter 0, 1, or 2."
    end
  end
end

