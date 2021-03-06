class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
    def create
     @genre=Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "You created genre successfully !!!!!"
      redirect_to admin_genres_path
        else
      flash.now[:notice] = "error !!!!!"
      render :new
    end
    end
   def index
    @genres=Genre.where(is_deleted: false).page(params[:page])
    @posts = Genre.where(is_deleted: false).search(params[:search]).page(params[:page])#@postは検索結果を入れる変数です。検索→リダイレクト時にこれを一覧表示します
  end

  def new
    @genre=Genre.new
  end


  def edit
    @genre=Genre.find(params[:id])
  end

  def update
    @genre=Genre.find(params[:id])
    if @genre.update(genre_params)
          flash[:notice]="Genre has successfully edited"
      redirect_to admin_genres_path
    else
      flash.now[:notice] = "error error not successfully edited!"
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.is_deleted = true
    @genre.save
    flash[:notice]="Genre has successfully deleted!"
    redirect_to admin_genres_path
  end

  private
    def genre_params
      params.require(:genre).permit(:name)
    end
end
