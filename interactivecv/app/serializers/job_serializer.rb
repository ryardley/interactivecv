class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :company, :location, :description, :start_date, :end_date, :skill_ids
end
