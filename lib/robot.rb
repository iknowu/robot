class Robot
  require 'toy/movable'
  require 'toy/steerable'

  include Toy::Movable
  include Toy::Steerable

  attr_reader :facing

  COMMAND_REGEX=/^(move|right|left|report|(place [0-5],[0-5],(north|west|east|south)))$/i

  def initialize
    @x_c=-1
    @y_c=-1
    @facing='NORTH'
  end

  def report
    puts self.to_s
  end

  def execute(command_line)
    if command_line=~COMMAND_REGEX
      ca=command_line.split(' ')
      send(ca.first.strip.downcase, *ca.fetch(1, '').split(','))
    end
  end

  def to_s
    [@x_c, @y_c, @facing].join(',')
  end

  alias current_post to_s

  def is_valid? *args
    args.empty? ? position_valid?(@x_c, @y_c) : position_valid?(*args)
  end

  def position_valid?(x, y, f='North')
    X_RANGE.include?(x.to_i) && Y_RANGE.include?(y.to_i)
  end

  def method_missing(name, *args)
    puts "robot can not recognise #{name}"
  end

  def self.before(*names)
    names.each do |name|
      m = instance_method(name)
      define_method(name) do |*args|
        if is_valid? *args
          m.bind(self).(*args)
        end
      end
    end
  end

  before(:move, :left, :right, :place)

end
