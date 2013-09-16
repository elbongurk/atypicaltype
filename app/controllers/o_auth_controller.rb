# TODO: Would be nice to abstract the instagram stuff out of here
class OAuthController < ApplicationController
  def disconnect
    sign_out "You have been signed out."
  end

  def connect 
    redirect_to Instagram.authorize_url(:redirect_uri => oauth_callback_url)
  end

  
  # TODO: Handle the case where the user denies access
  def callback
    rsp = Instagram.get_access_token(params[:code], :redirect_uri => oauth_callback_url)

    user = User.where(oauth_id: rsp.user.id).first_or_initialize.tap do |u|
      u.oauth_token = rsp.access_token
      u.username = rsp.user.username
      u.name = rsp.user.full_name
      u.avatar_url = rsp.user.profile_picture
    end

    user.save

    sign_in user

    redirect_back_or photos_url
  end
end
