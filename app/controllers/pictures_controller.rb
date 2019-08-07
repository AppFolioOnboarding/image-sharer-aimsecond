class PicturesController < ApplicationController
  def new; end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to action: :show, id: @picture.id
    else
      flash.now[:info] = @picture.errors[:link].first
      render :new, status: :unprocessable_entity
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
