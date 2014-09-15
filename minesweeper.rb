require 'yaml'
require_relative 'board'

class Minesweeper

  attr_reader :game

  def initialize
    @game = Board.new
  end

  def display
    @game.render
  end

  def play

    until self.game.over?
      pos, move = prompt

      if move == "R"
        self.game[pos].reveal
      elsif move == "F"
        self.game[pos].set_flag
      end
    end

    display

    if self.game.won?
      puts "Hurray!! You did it!"
    else
      puts "Kaboom!! You got exploded."
    end

  end

  def prompt
    display
    puts "What is your move? Please enter (x, y) coordinates."
    print "> "
    position = gets.chomp.split(",").map {|coord| Integer(coord)}
    puts "Do you want to reveal (R), or flag (F)?"
    print "> "
    move = gets.chomp.upcase

    [position, move]
  end

end

if __FILE__ == $PROGRAM_NAME
  ms = Minesweeper.new
  ms.play
end