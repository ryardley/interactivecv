class Skill < ActiveRecord::Base
  attr_accessible :group, :title, :job_ids

  has_and_belongs_to_many :jobs
end
