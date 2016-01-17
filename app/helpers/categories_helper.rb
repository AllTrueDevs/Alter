module CategoriesHelper
  class Color
    attr_accessor :id, :name

    def initialize(id, name)
      @id = id
      @name = name
    end

  end

  def colors
    colors = %w(Салатовий Зелений Синій Фіолетовий Жовтий Оранжевий Червоний Синій)
    temp = []
    (1..8).each{ |x| temp << Color.new(x, colors[x - 1])}
    temp
  end
end
