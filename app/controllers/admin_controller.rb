class AdminController < ApplicationController

  before_action :admin_user
  before_action :not_admin_user

  def index
  end


  private
  def admin_user
      redirect_to("/") unless @current_user.admin? #unlessはifの反対
  end
  
end
