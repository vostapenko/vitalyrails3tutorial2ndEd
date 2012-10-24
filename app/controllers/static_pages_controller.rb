class StaticPagesController < ApplicationController

  before_filter :set_locale

  def home
  end

  def help
  end

  def about
  end

  def contact
  end
end
