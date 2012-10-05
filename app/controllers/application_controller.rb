class ApplicationController < ActionController::Base

  protect_from_forgery
  include SessionsHelper

  def set_locale
    if signed_in?
      I18n.locale = current_user.locale
    else
      I18n.default_locale 
    end
  end
end
