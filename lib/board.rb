# frozen_string_literal: true

# The Board class encapsulates the state and behavior of the Tic-Tac-Toe game board.
# It handles rendering, move placement, validation, and win condition checks.
class Board
  WINNING_LINES = [
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
  ].map(&:freeze).freeze

  def initialize
    @grid = Array.new(3) { Array.new(3, '_') }
  end

  def display
    puts "\n"
    @grid.each { |row| puts row.join(' | ') }
    puts "\n"
  end

  def valid_move?(row, col)
    in_bounds?(row, col) && @grid[row][col] == '_'
  end

  def place_mark(row, col, mark)
    @grid[row][col] = mark if valid_move?(row, col)
  end

  def full?
    @grid.flatten.none?('_')
  end

  def winner
    WINNING_LINES.each do |line|
      marks = line.map { |r, c| @grid[r][c] }
      return marks.first if marks.uniq.size == 1 && marks.first != '_'
    end
    nil
  end

  def empty_positions
    positions = []
    @grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        positions << [i, j] if cell == '_'
      end
    end
    positions
  end

  private

  def in_bounds?(row, col)
    row.between?(0, 2) && col.between?(0, 2)
  end
end
