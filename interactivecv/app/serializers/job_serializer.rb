class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :company, :location, :description, :start_date, :end_date, :skill_ids, :content_image_ids, :lead_image_id
  
end
