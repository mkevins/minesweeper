class Square

  attr_accessor :value, :position
  attr_writer :flag, :revealed
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

  def flag?
    @flag
  end

  def revealed?
    @revealed
  end

  def inspect
    # puts "initialized!"
    # puts "position: #{@position}"
    # puts "value #{@value}"
    # puts "flag #{@flag}"
    # puts "revealed #{@revealed}"
    # puts "neighbor length #{@neighbors.length}"
  end

  def display_square
    if !self.revealed?
      print self.flag? ? "F" : "*"
    elsif self.value == 0
      print "_"
    elsif self.value == :bomb
      print "B"
    elsif self.value.between?(1, 8)
      print self.value
    end
  end

  def reveal
    if self.revealed?
      "Square already revealed."
    elsif self.flag?
      "Square has been flagged, cannot reveal."
    elsif self.value == :bomb
      self.revealed = true
      "Kaboom!! You picked a bomb; you lose."
    elsif self.value.between?(1, 8)
      self.revealed = true
      "Square revealed"
    elsif self.value == 0
      self.revealed = true

      self.neighbors.each do |neighbor|
        next if neighbor.revealed?
        neighbor.reveal
      end

      "Squares revealed"
    end

  end

  def set_flag
    if self.revealed?
      return "Square has already been revealed"
    else
      if self.flag?
        self.flag = false
        return "Flag has been removed."
      else
        self.flag = true
        return "Square has been flagged."
      end
    end
  end


end