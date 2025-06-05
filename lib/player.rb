# frozen_string_literal: true

# The Player class represents a player in the Tic-Tac-Toe game.
# It handles input and move selection, supporting both human and AI players.
class Player
  attr_reader :mark, :type

  def initialize(mark, type: :human)
    @mark = mark
    @type = type
  end

  def move(board)
    type == :ai ? ai_move(board) : human_move(board)
  end

  private

  def human_move(board)
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

  def prompt_coordinate(axis)
    loop do
      print "Enter #{axis} (0, 1, or 2): "
      input = gets.chomp
      return input.to_i if input.match?(/^[0-2]$/)

      puts "Invalid #{axis}. Please enter 0, 1, or 2."
    end
  end

  def ai_move(board)
    move = board.empty_positions.sample
    puts "AI (#{mark}) chooses #{move[0]}, #{move[1]}"
    move
  end
end
