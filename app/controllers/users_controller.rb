class UsersController < ApplicationController

  before_filter :signed_in_user,  only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: :destroy
  before_filter :set_locale,      except: [:create, :update]
  before_filter :deny_sign_up,    only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page], per_page: 30)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
      I18n.locale = "#{params[:user][:locale]}"
      @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = t(:flash_message)
      redirect_back_or @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
      I18n.locale = "#{params[:user][:locale]}"
    if @user.update_attributes(params[:user])
      flash[:success] = t(:flash_update)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.admin?
      flash[:notice] = t(:flash_admin_destroy)
      redirect_to users_url
    else
     user.destroy
     flash[:success] = t(:flash_destroy)
     redirect_to users_url
    end
  end

  def following
    @title = t(:following)
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = t(:followers)
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def correct_user 
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def deny_sign_up
    redirect_to(root_url) if signed_in?
  end
end
