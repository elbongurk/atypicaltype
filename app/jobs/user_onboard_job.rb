class UserOnboardJob < Struct.new(:user_id, :order)
  MAX_IMAGES = 20
  
  def perform
    user = User.find(user_id)

    options = { count: MAX_IMAGES }

    last_image = user.photos.order("created_at #{order}").last

    if last_image
      key = order == "desc" ? "max_timestamp" : "min_timestamp"
      options[key] = last_image.created_at.to_i
    end

    media = Instagram.client(:access_token => user.oauth_token).user_recent_media(options)
    
    media.each do |medium|
      low = medium.images.low_resolution
      created = Time.strptime(medium.created_time, '%s')
      user.photos << Photo.new(url: low.url, width: low.width, height: low.height, created_at: created, updated_at: created)
    end

    user.save
    
    if media.size == MAX_IMAGES
      Delayed::Job.enqueue self, run_at: Time.now + 1.second
    end
  end
end
