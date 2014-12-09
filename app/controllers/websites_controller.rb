class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy]

  # GET /websites
  def index
    @websites = Website.all
  end

  # GET /websites/1
  def show
  end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/edit
  def edit
  end

  # POST /websites
  def create
    @website = Website.new(website_params)
    if @website.save
      flash[:success] = 'Welcome to Sample App!'
      redirect_to @website
    else
      render 'new'
    end
  end

  # PATCH/PUT /websites/1
  def update
    if @website.update(website_params)
      redirect_to @website, notice: 'Website was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /websites/1
  def destroy
    @website.destroy
    redirect_to websites_url, notice: 'Website was successfully destroyed.'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_website
      @website = Website.find(params[:id])
    end

    def website_params
      params.require(:website).permit(:url)
    end
end
