class Admin::UsersController < ApplicationController
    before_action :admin_user
    before_action :not_admin_user
    
    def index
        @users = User.all.order(:id)
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
            redirect_to("/admin/users/index")
        else
            render("admin/users/edit")
        end
    end
    
    def destroy
        @users = User.find_by(id: params[:id])
        @users.destroy
        flash[:notice] = "削除しました"
        redirect_to("/admin/users/index")
    end
end
