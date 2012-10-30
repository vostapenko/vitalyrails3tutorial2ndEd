class MicropostsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy] 
  before_filter :correct_user, only: :destroy
  before_filter :set_locale

  def index
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = t(:flash_create_micropost)
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
