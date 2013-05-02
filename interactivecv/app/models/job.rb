class Job < ActiveRecord::Base
  attr_accessible :company, :description, :end_date, :location, :start_date, :title
end
