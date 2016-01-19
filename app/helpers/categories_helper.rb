module CategoriesHelper

  def colors
    colors = %w(Салатовий Зелений Синій Фіолетовий Жовтий Оранжевий Червоний Синій)
    (1..8).map{ |x| [colors[x - 1], x] }
  end

end
