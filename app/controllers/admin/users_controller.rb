class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :destroy, :update]

  def index
   # @users = User.all.order(created_at: :desc)
   @users = User.select(:id, :name, :email, :admin).order(created_at: :desc).includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to admin_users_path
      else
        render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private
    def if_not_admin
      unless current_user.admin?
        redirect_to root_path
        flash[:notice]="管理者以外はアクセスできません"
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confimation)
    end
end
