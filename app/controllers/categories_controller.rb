class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy]
  load_and_authorize_resource except: [:create]

  def index
    @categories = Category.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @category = Category.new(category_params)
    @category.color = params[:color].to_i
    respond_to do |format|
      @category.save ? format.html { redirect_to categories_path, notice: 'Категорію успішно додано.' } :
          format.html { redirect_to categories_path, notice: 'Заповніть усі поля.'}
    end
  end

  def update
    @category.update(color: params[:color])
    respond_to :js
  end

  def destroy
    if @category.required_items.empty? && @category.helped_items.empty?
      @category.destroy
      redirect_to categories_url
    else
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Неможливо видалити категорію.' }
      end
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :color)
  end
end
