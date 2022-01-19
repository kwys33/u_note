class Admin::PostsController < ApplicationController
    before_action :admin_user
    before_action :not_admin_user

    def index
        @posts = Post.all.order(:id)
    end

    def show
        @posts = Post.find_by(id:params[:id])
    end

    def edit
        @posts = Post.find_by(id:params[:id])
    end
    
    def update
        @posts = Post.find_by(id:params[:id])
        @posts.memo = params[:memo]
        @posts.date = params[:date]
        @posts.when = params[:when]
        if @posts.save
            flash[:notice] = "編集しました"
            redirect_to("/admin/posts/index")
        else
            render("admin/posts/edit")
        end
    end

    def destroy
        @posts = Post.find_by(id: params[:id])
        @posts.destroy
        flash[:notice] = "削除しました"
        redirect_to("/admin/posts/index")
    end  
end
