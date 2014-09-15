require_relative 'board'

class Square

  attr_accessor :value, :position, :flag, :revealed
  attr_reader :neighbors

  def initialize(position, options = {})
    defaults = {
      value: nil,
      flag: false,
      revealed: true
    }

    options = defaults.merge(options)
    @position = position
    @value = options[:value]
    @flag = options[:flag]
    @revealed = options[:revealed]
    @neighbors = []
  end

  def inspect
    puts "initialized!"
    # puts "position: #{@position}"
    # puts "value #{@value}"
    # puts "flag #{@flag}"
    # puts "revealed #{@revealed}"
    # puts "neighbor length #{@neighbors.length}"
  end

  def display_square
    if !self.revealed
      print self.flag ? "F" : "*"
    elsif self.value == 0
      print "_"
    elsif self.value == :bomb
      print "B"
    elsif self.value.between?(1, 8)
      print self.value
    end
  end

end