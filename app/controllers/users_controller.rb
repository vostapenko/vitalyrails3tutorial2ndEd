class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 30)
    set_locale
  end

  def show
    @user = User.find(params[:id])
    set_locale
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      set_locale
      flash[:success] = t(:flash_message)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      set_locale
      flash[:success] = t(:flash_update)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
     User.find(params[:id]).destroy
     set_locale
     flash[:success] = t(:flash_destroy)
     redirect_to users_url
  end

  private

  def signed_in_user
    unless signed_in?
    store_location
    redirect_to signin_url 
    flash[:notice] =  t(:flash_signin)
    end
  end

  def correct_user 
    @user = User.find(params[:id])
    set_locale
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
