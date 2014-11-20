module Toy
  module Movable

    STEP=1
    X_RANGE=(0..5)
    Y_RANGE=(0..5)

    def move
      send("go_#{@facing.downcase}")
    end

    def go_north
      @y_c=[@y_c+STEP, Y_RANGE.max].min
    end

    def go_south
      @y_c=[@y_c-STEP, Y_RANGE.min].max
    end

    def go_west
      @x_c=[@x_c-STEP, X_RANGE.min].max
    end

    def go_east
      @x_c=[@x_c+STEP, X_RANGE.max].min
    end

    def place(x, y, f)
      @x_c=x.to_i
      @y_c=y.to_i
      @facing=f.upcase
    end
  end
end