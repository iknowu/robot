module Toy
  module Steerable
    def right
      self.send("turn_right_when_facing_#{@facing.downcase}")
    end

    def left
      self.send("turn_left_when_facing_#{@facing.downcase}")
    end

    def turn_right_when_facing_north
      @facing='EAST'
    end

    def turn_right_when_facing_south
      @facing='WEST'
    end

    def turn_right_when_facing_west
      @facing='NORTH'
    end

    def turn_right_when_facing_east
      @facing='SOUTH'
    end

    def turn_left_when_facing_north
      @facing='WEST'
    end

    def turn_left_when_facing_south
      @facing='EAST'
    end

    def turn_left_when_facing_west
      @facing='SOUTH'
    end

    def turn_left_when_facing_east
      @facing='NORTH'
    end
  end
end