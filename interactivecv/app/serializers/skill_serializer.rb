class SkillSerializer < ActiveModel::Serializer
  attributes :id, :title, :group, :job_ids
end
