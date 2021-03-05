class BlogsController < ApplicationController
  before_action :login_required
  before_action :ensure_correct_user, only: %i[edit update]

  def index
    # N+1問題の解消の為includes使用
    @blogs = Blog.includes(:user).order(created_at: :desc)
  end

  def new
    @blog = Blog.new
  end

  def create
    # 関連するオブジェクトを作成するのでnewじゃなくてbuildを使用
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blogs_path, success: 'ブログ記事を作成しました'
    else
      flash.now[:danger] = 'ブログ記事の作成に失敗しました'
      render :new
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
  end

  def update
    @blog = current_user.blogs.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blog_path, success: 'ブログ記事を更新しました'
    else
      flash.now[:danger] = 'ブログ記事の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @blog = current_user.blogs.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, success: 'ブログ記事を削除しました'
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :body, :status)
  end

  # ログインユーザーIDと、投稿ユーザーIDが一致しなければroot_urlに遷移させる
  def ensure_correct_user
    blog = Blog.find_by(id: params[:id])
    if current_user.id != blog.user_id
      redirect_to root_url
    end
  end

  # ログインしていなければログインページに遷移させる
  def login_required
    redirect_to login_url unless current_user
  end
end
