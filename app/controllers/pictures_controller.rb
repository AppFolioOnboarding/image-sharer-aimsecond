class PicturesController < ApplicationController
  def new; end

  def index
    @pictures = if params[:tag_list].empty?
                  Picture.all
                else
                  Picture.tagged_with(params[:tag_list])
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

  private

  def picture_params
    params.require(:picture).permit(:name, :link, :tag_list)
  end
end
