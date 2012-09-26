class ApplicationController < ActionController::Base

  protect_from_forgery

  def set_locale (user)
      I18n.locale = user.locale
  end
end
