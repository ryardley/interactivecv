class Job < ActiveRecord::Base
  attr_accessible :company, :description, :end_date, :location, :start_date, :title, :skill_ids
  
  
  has_and_belongs_to_many :skills
end
