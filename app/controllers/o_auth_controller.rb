# TODO: Would be nice to abstract the instagram stuff out of here
class OAuthController < ApplicationController
  def disconnect
    sign_out "You have been signed out."
  end

  def connect 
    redirect_to Instagram.authorize_url(:redirect_uri => oauth_callback_url)
  end
  
  # http://instagram.com/developer/realtime/#create-a-subscription
  def subscribe
    render text: params['hub.challenge']
  end
  
  # http://instagram.com/developer/realtime/#user-subscriptions
  def realtime
    Instagram.process_subscription(request.raw_post, signature: request.headers['X-Hub-Signature']) do |handler|
      handler.on_user_changed do |user_id, data|
        user = User.where(oauth_id: user_id).first
        Delayed::Job.enqueue UserOnboardJob.new(user.id, 'asc')
      end
    end
  end
  
  def callback
    if params[:error].present?
      return redirect_to root_url
    end
  
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
