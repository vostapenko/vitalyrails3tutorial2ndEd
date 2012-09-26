class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    set_locale @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      set_locale @user
      flash[:success] = t(:flash_message)
      redirect_to @user
    else
      render 'new'
    end
  end
end
