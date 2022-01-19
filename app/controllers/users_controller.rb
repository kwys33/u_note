require "json" 
require "open-uri"

class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]} #ログインしてないユーザーがアクセスできない
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]} #ログイン済ユーザーがアクセスできない



  def index
    @users = User.all.order(:id)
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new(
      name: params[:name],
      email: params[:email],
      postalcode: params[:postalcode],
      password: params[:password]
    )

    if @users.save
      session[:user_id] = @users.id
      flash[:notice] = "登録しました"
      redirect_to("/users/#{@users.id}")
    else
      flash[:notice] = "何か失敗してます"
      render("users/new")
    end
  end

  def show
    @users = User.find_by(id:params[:id])
  end

  def edit
    @users = User.find_by(id:params[:id])
  end

  def update
    @users = User.find_by(id:params[:id])
    @users.name = params[:name]
    @users.email = params[:email]
    @users.postalcode = params[:postalcode]
    @users.password = params[:password]
    if @users.save
      flash[:notice] = "編集しました"
      redirect_to("/users/index")
    else
      render("users/edit")
    end
  end

  def destroy
    @users = User.find_by(id: params[:id])
    @users.destroy
    flash[:notice] = "削除しました"
    redirect_to("/users/index")
  end

  def login_form
  end

  def login
      @users = User.find_by(email: params[:email],
                            password: params[:password])
      if @users
        session[:user_id] = @users.id
        flash[:notice] = "ログインしました"
        redirect_to("/posts/index")
      else
        @error_message = "メールアドレスまたはパスワードが間違っています"
        @email = params[:email]
        @password = params[:password] 
        render("users/login_form")
      end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
end
