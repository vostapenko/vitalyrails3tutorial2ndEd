class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url
    flash[:notice] = t(:flash_password_resets_create)

  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    @password = "#{params[:user][:password]}"
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_url
      flash[:error] = t(:flash_password_resets_error)
    elsif @password.to_s.blank?
      redirect_to edit_password_reset_url
      flash[:error] = t(:flash_password_blank_error)
    elsif @user.update_attributes(params[:user])
      redirect_to root_url
      flash[:notice] = t(:flash_password_resets_update)
    else 
      render 'edit'
    end
  end
end
