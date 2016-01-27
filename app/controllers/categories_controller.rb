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
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
      else
        format.html { redirect_to categories_path, notice: 'Category was not created.'}
      end
    end
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

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :color)
  end
end
