class PicturesController < ApplicationController
  def new; end

  def index
    @pictures = if params[:tag].blank?
                  Picture.all
                else
                  Picture.tagged_with(params[:tag])
                end
  end

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

  def destroy
    @picture = Picture.find(params[:id])
    @picture&.destroy

    redirect_to pictures_path
  end

  private

  def picture_params
    params.require(:picture).permit(:name, :link, :tag_list)
  end
end
