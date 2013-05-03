class ContentImageSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :picture,
              :picture_large, 
              :picture_medium,
              :picture_thumb
    
  def picture_large
    picture.url(:large)
  end
  def picture_medium
    picture.url(:medium)
  end
  def picture_thumb
    picture.url(:thumb)
  end
end
