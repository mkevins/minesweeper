require_relative 'board'
require_relative 'square'

class Minesweeper

  def initialize
    @game = Board.new
  end

  def display
    @game.render
  end

end