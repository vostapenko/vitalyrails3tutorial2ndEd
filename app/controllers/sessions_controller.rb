class SessionsController < ApplicationController

  def new
  end

  def create
     user = User.find_by_email(params[:email].downcase)
     if user && user.authenticate(params[:password])
       sign_in user
       set_locale
       redirect_back_or user
     else
       set_locale
       flash.now[:error] = t(:flash_error)
       render 'new'
      end
    end

  def destroy
    set_locale
    sign_out
    redirect_to root_url
  end
end
