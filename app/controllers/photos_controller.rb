class PhotosController < ApplicationController
  before_filter :authorize
  respond_to :html, :pdf, :png, only: [:show]
  
  def index
    # TODO: We should attempt to cache the urls for these guys
    # we could start by doing the following
    # 1) If this has no "since" param then query our DB first then check API
    # 2) If there is a "since" param then check API
    # 3) Anything from the API gets saved in the DB
    @photos = current_user.photos
  end

  def show
    # TODO: We should be pulling this from cache rather than query
    # we could shart by doing the following
    # 1) Query our DB first then check API
    # 2) Anything from the API gets saved in the DB
    # 3) We should set far cache headers varied by params so our CDN will cache
    @photo = current_user.photo(params[:id])

    respond_with(@photo)
  end
end
