module CategoriesHelper
  COLORS = %w(Салатовий Зелений Синій Фіолетовий Жовтий Оранжевий Червоний Синій)

  def colors
    (1..8).map{ |x| [COLORS[x - 1], x] }
  end
end

