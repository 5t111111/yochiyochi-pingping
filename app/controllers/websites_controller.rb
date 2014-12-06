class WebsitesController < ApplicationController
  def show
    @website = Website.find(params[:id])
  end

  def new
    @website = Website.new
  end

  def create
    @website = Website.new(website_params)
    if @website.save
      flash[:success] = 'Welcome to Sample App!'
      redirect_to @website
    else
      render 'new'
    end
  end

  private

  def website_params
    params.require(:website).permit(:url)
  end
end
