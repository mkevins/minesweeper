require_relative 'square'

class Board

  NEIGHBORS = [
    [-1, -1], [0, -1], [1, -1],
    [-1, 0],           [1, 0],
    [-1, 1],  [0, 1],  [1, 1]
  ]

  attr_reader :dimensions
  attr_writer :won, :over

  def initialize(dimensions = [9, 9])
    # debugger
    @dimensions = dimensions
    @num_mines = 10
    @rows = Array.new(@dimensions[1]) do |y|
      Array.new(@dimensions[0]) {|x| Square.new([x, y]) }
    end
    place_bombs(random_bomb_positions)
    set_neighbors
    set_values
    @over = false
    @won = false

  end

  def [](pos)
    x, y = pos
    @rows[y][x]
  end

  def []=(pos, square)
    x, y = pos
    @rows[y][x] = square
  end

  def random_bomb_positions
    bomb_positions = []

    until bomb_positions.length >= @num_mines
      x = rand(self.dimensions[0])
      y = rand(self.dimensions[1])
      bomb_positions << [x, y] unless bomb_positions.include?([x, y])
    end

    bomb_positions
  end

  def place_bombs(positions)
    positions.each do |position|
      self[position].value = :bomb
    end

    nil
  end

  def all_squares(&prc)
    (0...@dimensions[0]).each do |x|
      (0...@dimensions[1]).each do |y|
        prc.call([x, y])
      end
    end

    nil
  end

  def set_neighbors

    all_squares do |position|
      x, y = position
      current_square = self[position]

      NEIGHBORS.each do |neighbor|
        dx, dy = neighbor
        new_neighbor = [x + dx, y + dy]
        nx, ny = new_neighbor

        if nx.between?(0, dimensions[0] - 1) && ny.between?(0, dimensions[1] - 1)
          neighbor_square = self[new_neighbor]
          current_square.neighbors << neighbor_square
        end
      end
    end

    nil
  end

  def set_values
    # debugger

    all_squares do |position|
      count = 0
      current_square = self[position]
      # p current_square
      next if current_square.value == :bomb

      current_square.neighbors.each do |neighbor|
        count += 1 if neighbor.value == :bomb
      end

      current_square.value = count
    end

    nil
  end

  def render
    puts "   0  1  2  3  4  5  6  7  8"

    (0...@dimensions[1]).each do |y|
      print "#{y}  "

      (0...@dimensions[0]).each do |x|

        current_square = self[[x, y]]
        current_square.display_square
        print "  "

      end
      print "\n"
    end
  end

  def hit_bomb?
    @rows.flatten.select(&:revealed?).any? { |square| square.value == :bomb }
  end

  def over?
    hit_bomb? || won?
  end

  def won?
    total_squares = @dimensions[0] * @dimensions[1]
    revealed_squares = @rows.flatten.select(&:revealed?).count

    if @num_mines == total_squares - revealed_squares
      return true
    end

    false
  end

end