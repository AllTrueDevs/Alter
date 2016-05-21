class ChangeCategoryColorField < ActiveRecord::Migration
  def change
    change_column :categories, :color, :string
  end
end
