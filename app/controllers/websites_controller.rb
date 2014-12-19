class WebsitesController < ApplicationController
  before_action :set_website, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :owner_user, only: [:edit, :update, :destroy]
  before_action :prepare_websites, only: [:index, :create]

  # GET /websites
  def index
    @website = current_user.websites.build if logged_in?
  end

  # GET /websites/edit
  def edit
  end

  # POST /websites
  def create
    @website = current_user.websites.build(website_params)
    if @website.save
      flash[:success] = 'Webサイトの情報は正常に登録されました'
      redirect_to root_path
    else
      render :index
    end
  end

  # PATCH/PUT /websites/1
  def update
    if @website.update(website_params)
      flash[:success] = 'Webサイトの情報は正常に更新されました'
      redirect_to root_path
    else
      render :edit
    end
  end

  # DELETE /websites/1
  def destroy
    @website.destroy
    flash[:success] = 'Webサイトの情報は正常に削除されました'
    redirect_to root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_website
    @website = Website.find(params[:id])
  end

  def website_params
    params.require(:website).permit(:url)
  end

  def prepare_websites
    @websites = Website.all.includes(:user)
  end

  def owner_user
    if current_user.nil?
      flash[:danger] = 'ログインが必要です'
      redirect_to root_path
    elsif current_user.websites.include?(@website) == false
      flash[:danger] = 'このページへの操作は許可されていません'
      redirect_to root_path
    end
    true
  end
end
