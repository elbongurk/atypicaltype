class UserOnboardJob < Struct.new(:user_id, :order)
  MAX_IMAGES = 20
  
  def perform
    user = User.find(user_id)

    options = { count: MAX_IMAGES }

    last_image = user.photos.order("created_at #{order}").last

    if last_image
      if order == "desc"
        options[:max_timestamp] = last_image.created_at.to_i
      else
        options[:min_timestamp] = last_image.created_at.to_i + 1
      end
    end

    media = Instagram.client(:access_token => user.oauth_token).user_recent_media(options)
    
    media.each do |medium|
      low = medium.images.low_resolution
      created = Time.strptime(medium.created_time, '%s')
      user.photos << Photo.new(url: low.url, width: low.width, height: low.height, created_at: created, updated_at: created)
    end

    user.save
    
    if order == 'desc' && media.size < MAX_IMAGES
      job = UserOnboardJob.new(user_id, 'asc')
    else
      job = self
    end
    
    queue_time = job.order == "desc" ? 1.second : 3.minutes

    Delayed::Job.enqueue job, run_at: Time.now + queue_time
  end
end
