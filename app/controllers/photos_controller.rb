class PhotosController < ApplicationController
  respond_to :html, :json
  before_filter :authorize

  def index
    @photos = current_user.photos

    if params[:since]
      @photos = @photos.where("created_at < ?", Time.at(params[:since].to_i))
    end
    
    @photos = @photos.order('created_at desc').limit(12)
    
    respond_with(@photos)
  end
end
