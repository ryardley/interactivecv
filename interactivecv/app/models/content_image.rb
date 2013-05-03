class ContentImage < ActiveRecord::Base
  attr_accessible   :title, 
                    :picture, 
                    :job_id
  
  belongs_to        :job
  
  has_attached_file :picture, 
                      :styles => { 
                        :large => "960x540#", 
                        :medium => "640x360#", 
                        :thumb => "320x180#" 
                      },
                      :default_url => "http://rudiyardley.com/assets/templates/main/img/logo.png"
                      
  
  
end
