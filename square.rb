require_relative 'board'

class Square

  attr_accessor :value, :position, :flag, :revealed
  attr_reader :neighbors

  def initialize(position, options = {})
    defaults = {
      value: nil,
      flag: false,
      revealed: false
    }

    options = defaults.merge(options)
    @position = position
    @value = options[:value]
    @flag = options[:flag]
    @revealed = options[:revealed]
    @neighbors = []
  end

  def inspect
    puts "position: #{@position}"
    puts "value #{@value}"
    puts "flag #{@flag}"
    puts "revealed #{@revealed}"
    puts "neighbor length #{@neighbors.length}"
  end


end