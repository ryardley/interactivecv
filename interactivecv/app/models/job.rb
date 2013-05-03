class Job < ActiveRecord::Base
  attr_accessible :company, 
                  :description, 
                  :end_date, 
                  :location, 
                  :start_date, 
                  :title, 
                  :skill_ids, 
                  :content_images_attributes, 
                  :lead_image_id
                  
  has_many        :content_images
   
  has_and_belongs_to_many :skills
  
  accepts_nested_attributes_for :content_images, allow_destroy: true
  
  def lead_image
    if self.content_images.any?
      if self.lead_image_id.nil?
        # select the first image
        self.content_images.first      
      else
        # select the first image by id = self.lead_image_id
        self.content_images.select{ |a| a.id == self.lead_image_id}.first
      end
    end
  end
end
