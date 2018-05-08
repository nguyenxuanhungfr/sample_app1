class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.user_info.paginate page: params[:page],
      per_page: Settings.user_model.page_size
  end

  def show
    @user = User.find params[:id]
    redirect_to root_url && return unless @user.activated == true
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "flast_info_check"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find params[:id].destroy
    flash[:success] = t "user_deleted"
    redirect_to users_url
  end

  private
<<<<<<< 7325f91886176ef4bc0423c0fd9ca0d302443664

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
=======
    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t "please_login"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find params[:id]
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
>>>>>>> chap11
end
