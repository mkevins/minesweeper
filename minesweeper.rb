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
      moves = prompt
      next if moves.nil?
      pos, move = moves

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
    puts "(or 's' to save)"
    print "> "
    command = gets.chomp
    if command.downcase.strip == 's'
      save
      return nil
    else
      position = command.split(",").map {|coord| Integer(coord)}
      puts "Do you want to reveal (R), or flag (F)?"
      print "> "
      move = gets.chomp.upcase
    end

    [position, move]
  end

  def save
    File.write('./saves/saved_game.yaml', self.to_yaml)

  end

end

if __FILE__ == $PROGRAM_NAME
  load_file = ARGV.shift
  if load_file
    ms2 = YAML::load(File.read(load_file))
    ms2.play
  else

    ms = Minesweeper.new

    ms.play
  end
end