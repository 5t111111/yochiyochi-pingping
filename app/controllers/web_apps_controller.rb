class WebAppsController < ApplicationController
  def new
    @web_app = WebApp.new
  end

  def create
    @web_app = WebApp.new(web_app_params)
    if @web_app.save
      flash[:success] = 'Welcome to Sample App!'
      render 'new'
    else
      render 'new'
    end
  end

  private

    def web_app_params
      params.require(:web_app).permit(:url)
    end
end
