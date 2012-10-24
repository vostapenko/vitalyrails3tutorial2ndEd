class SessionsController < ApplicationController

  before_filter :set_locale

  def new
  end

  def create
     user = User.find_by_email(params[:email].downcase)
     if user && user.authenticate(params[:password])
       sign_in user
       redirect_back_or user
     else
       flash.now[:error] = t(:flash_error)
       render 'new'
      end
    end

  def destroy
    sign_out
    redirect_to root_url
  end
end
