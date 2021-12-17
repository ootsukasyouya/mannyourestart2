class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :ensure_current_user, only: %i[ new ]
  def new
    @user = User.new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
       render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to tasks_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,  :password_confirmation)
  end
  def ensure_current_user
    if current_user.present?
      redirect_to tasks_path
      flash[:notice]="権限がありません"

    end
  end


end
