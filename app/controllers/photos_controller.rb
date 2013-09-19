class PhotosController < ApplicationController
  before_filter :authorize, only: :index
  respond_to :html, :png, :pdf, only: :canvas

  def index
    @photos = current_user.photos
  end

  def canvas
    @photo = Photo.find(params[:id])

    contrast = params[:contrast].to_i
    brightness = params[:bright].to_i

    respond_with(@photo, contrast: contrast, bright: brightness)
  end

  def show
    redirect_to canvas_photo_url(params[:id])
  end
end
