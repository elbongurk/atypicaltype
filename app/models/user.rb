# TODO: Would be nice to abstract the instagram stuff out of here
class User < ActiveRecord::Base
  has_one :cart, -> { where orders_count: 0 }
  has_many :carts
  has_many :orders, through: :carts

  def photos
    client.user_recent_media.map do |media|
      photo_from_media(media)
    end
  end

  def photo(id)
    photo_from_media(client.media_item(id))
  end

  private

  def client
    Instagram.client(:access_token => self.oauth_token)
  end
  
  def photo_from_media(media)
    image = media.images.low_resolution
    Photo.new(id: media.id, url: image.url, width: image.width, height: image.height)
  end
end
