class PhotosController < ApplicationController
  before_filter :authorize, except: :show
  respond_to :html, :png, :pdf, only: :show

  # TODO: this will eventually have to have a :since param and respond to json
  def index
    @photos = current_user.photos
  end

  def show
    @photo = Photo.find(params[:id])

    contrast = params[:contrast].to_i
    brightness = params[:bright].to_i

    respond_with(@photo, contrast: contrast, bright: brightness)
  end
end
