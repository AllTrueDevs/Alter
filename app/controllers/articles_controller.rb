class ArticlesController < ApplicationController
  load_and_authorize_resource except: [:create, :show, :index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :destroy, :new, :update]
  before_action :fill_tags, only: [:new, :edit]

  def index
    @articles = Article.all.order(:name).page(params[:page]).per(8)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    respond_to do |format|
      if @article.save
        current_user.create_unique_tags(article_params[:tag_list], :news)
        format.html { redirect_to show_article_url(@article, url: @article.article_url), notice: 'Новину успішно добавлено.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        current_user.create_unique_tags(article_params[:tag_list], :news)
        format.html { redirect_to show_article_url(@article, url: @article.article_url), notice: 'Новину успішно відредаговано.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to news_url, notice: 'Новину успішно видалено.' }
    end
  end


  private


  def fill_tags
    gon.default_tags_collection = current_user.news_tags.pluck(:value)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :body, :photo, :src, :tag_list)
  end
end
