class Square

  attr_accessor :value, :position, :flag, :revealed, :neighbors

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

  def set_neighbors


  end
end