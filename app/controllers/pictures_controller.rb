class PicturesController < ApplicationController
  def new; end

  def create
    @picture = Picture.new(picture_params)
    if @picture.valid?
      @picture.save
      redirect_to @picture
    else
      flash.now[:info] = 'Incorrect Image URL!'
      render :new
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end

  private

  def picture_params
    params.require(:picture).permit(:name, :link)
  end
end
