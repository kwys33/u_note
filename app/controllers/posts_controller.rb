require "json" 
require "open-uri"

require 'uri'
require 'net/http'

class PostsController < ApplicationController
  before_action :authenticate_user

  def index
    @posts = Post.where(user_id: @current_user.id)
  end

  def show
    @posts = Post.find_by(id:params[:id])
    @user = @posts.user
  end

  def create
    sippai = false
    api_key = "e790cb63ccb9d5a53515a0b22361d69d"
    base_url = "http://api.openweathermap.org/data/2.5/weather"
      if params[:postalcode1].present? && params[:postalcode2].present? 
        postalcode = params[:postalcode1] + "-" + params[:postalcode2]
      elsif  @current_user.postalcode.present?
        postalcode = @current_user.postalcode
      end
      uri = URI(base_url + "?zip=#{postalcode},jp&APPID=#{api_key}") #アクセス先のURL
      res = Net::HTTP.get_response(uri) #アクセス先のURLの中身を取る処理 Openと一緒
      if res.is_a?(Net::HTTPSuccess) #アクセス先の中身が存在するか確認する
        response = open(base_url + "?zip=#{postalcode},jp&APPID=#{api_key}")
        results = JSON.parse(response.read)
        @weather = results ["weather"][0]["main"]
      else
        sippai = true #もしアクセス失敗した場合
      end
      

    @post = Post.new(
      memo:params[:memo],
      when:params[:when],
      date:params[:date],
      weather: @weather,
      user_id: @current_user.id
    )

    if sippai == false #失敗していなければセーブする処理
      @post.save
      flash[:notice] = "投稿しました"
      redirect_to("/posts/index")
    else 
      flash[:notice] = "何か失敗してます"
      @posts = Post.where(user_id: @current_user.id)
      render("posts/index")
    end
  end

  def edit
    @posts = Post.find_by(id: params[:id])
  end

  def update
    @posts = Post.find_by(id:params[:id])
    @posts.memo = params[:memo]
    @posts.date = params[:date]
    @posts.when = params[:when]
    if @posts.save
      flash[:notice] = "編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @posts = Post.find_by(id: params[:id])
    @posts.destroy
    flash[:notice] = "削除しました"
    redirect_to("/posts/index")
  end  

end
