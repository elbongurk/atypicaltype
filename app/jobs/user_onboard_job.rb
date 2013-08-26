class UserOnboardJob < Struct.new(:user_id)
  # We need to continously do this
  def perform
    user = User.find(user_id)

    Instagram.client(:access_token => user.oauth_token).user_recent_media.map do |media|
      image = media.images.low_resolution
      user.photos << Photo.new(url: image.url, width: image.width, height: image.height)
    end
    
    user.save

    # TOOD: need to check if we have to enqueue another of these
  end
end
