class ActivationsController < ApplicationController

  def update
    @user = User.find_by_activation_token!(params[:id])
    @user.update_attribute(:active, true)
    flash[:notice] = t(:flash_activation)
    redirect_to root_path
  end
end
