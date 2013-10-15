class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :url, :created_time
end