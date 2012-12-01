class StaticPagesController < ApplicationController

  before_filter :set_locale

  def home
    if signed_in?
    @micropost = current_user.microposts.build 
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
