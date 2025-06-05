# frozen_string_literal: true

# The Game class represents a simple Tic-Tac-Toe game.
# It manages the game board, player turns, and determines the winner.
# Players take turns to place their marks (:X or :O) on a 3x3 grid.
# The game ends when a player has three of their marks in a row, column, or diagonal, or when the board is full.
class Game
  attr_accessor :current_mark, :ai_mark, :board, :winner

  def initialize
    @board = Array.new(3) { Array.new(3, '_') }
    @current_mark = :X # or :O, depending on who you want to start
    @ai_mark = :O
  end

  def display
    puts "\n"
    board.each do |row|
      puts row.join(' | ')
    end
    puts "\n"
  end

  def ask_for_move
    row = nil
    col = nil

    loop do
      puts 'Enter the row number (0, 1, or 2):'
      row = gets.chomp.to_i
      break if [0, 1, 2].include?(row)

      puts 'Invalid input. Please enter 0, 1, or 2.'
    end

    loop do
      puts 'Enter the column number (0, 1, or 2):'
      col = gets.chomp.to_i
      break if [0, 1, 2].include?(col)

      puts 'Invalid input. Please enter 0, 1, or 2.'
    end

    [row, col]
  end

  def place_move
    if current_mark == ai_mark # Replace :AI with the mark you assign for the computer
      row, col = ai_move
      puts "AI places on #{row}, #{col}"
      board[row][col] = current_mark
    else
      loop do
        row, col = ask_for_move
        if %i[X O].include?(board[row][col])
          puts 'Slot already taken. Please choose another move.'
        else
          board[row][col] = current_mark
          break
        end
      end
    end
  end

  def ai_move
    empty_slots = []
    board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        empty_slots << [i, j] if cell == '_'
      end
    end
    empty_slots.sample
  end

  def switch_player
    self.current_mark = current_mark == :X ? :O : :X
  end

  def check_winner
    win_positions = [
      # Rows
      [[0, 0], [0, 1], [0, 2]],
      [[1, 0], [1, 1], [1, 2]],
      [[2, 0], [2, 1], [2, 2]],
      # Columns
      [[0, 0], [1, 0], [2, 0]],
      [[0, 1], [1, 1], [2, 1]],
      [[0, 2], [1, 2], [2, 2]],
      # Diagonals
      [[0, 0], [1, 1], [2, 2]],
      [[0, 2], [1, 1], [2, 0]]
    ]

    win_positions.each do |line|
      marks = line.map { |r, c| board[r][c] }
      next if marks.include?('_') # Skip if any spot is empty

      next unless marks.uniq.size == 1

      display
      self.winner = current_mark
      puts "#{winner} won"
      return winner
    end

    nil
  end

  def play
    while winner.nil?
      display
      place_move
      check_winner
      switch_player
    end
  end
end
