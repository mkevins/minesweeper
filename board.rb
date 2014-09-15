
class Board

  attr_reader :dimensions

  def initialize(dimensions = [9, 9])
    @dimensions = dimensions
    @num_mines = 10
    @rows = Array.new(@dimensions[0]) do
      Array.new(@dimensions[1]) { Square.new }
    end
    place_bombs(random_bomb_positions)
    fill_squares
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[y][x]
  end

  def []=(pos, square)
    # defaults = { # maybe move this to Square initialize
    #   value: nil,
    #   position: pos,
    #   flag: false,
    #   revealed: false
    # }

    options = defaults.merge(options)
    x, y = pos[0], pos[1]
    @rows[y][x] = square
  end

  def random_bomb_positions
    bomb_positions = []

    until bomb_positions.length >= num_mines
      x = rand(self.dimensions[0])
      y = rand(self.dimensions[1])
      bomb_positions << [x, y] unless bomb_positions.include?([x, y])
    end

    bomb_positions
  end

  def place_bombs(positions)
    positions.each do |position|
      self[position].make_bomb # to be defined as bomb #  = Square.new({ value: bomb })
    end

    nil
  end

  def fill_squares
    (0...@dimesions[0]).each do |x|
      (0...@dimensions[1]).each do |y|
        position = [x, y]
        next unless self[position].nil?

      end
    end

  end

end