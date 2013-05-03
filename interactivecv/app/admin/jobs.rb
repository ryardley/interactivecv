ActiveAdmin.register Job do
  
  menu  :parent => "Content",
        :label => "Jobs"
  
  config.clear_sidebar_sections!
  
  show do
     attributes_table do

       row :image do
         link_to(image_tag(job.lead_image.nil? ? content_tag(:span, "No image uploaded") : job.lead_image.picture.url(:thumb)), edit_admin_job_path(job))
       end
       row :title
       row :company
       row :description
       row :start_date       
       row :end_date  
       row :skills
     end
   end
  
  index :download_links => false  do                            
    column 'Thumbnail' do |job|
         link_to(image_tag(job.lead_image.nil? ? content_tag(:span, "No image uploaded") : job.lead_image.picture.url(:thumb)), edit_admin_job_path(job))
    end
    column :title
    column :company    
    
      
    default_actions
  end  
  
  form do |f|                         
    f.inputs "Job Basics" do       
      f.input :title
      f.input :company
      f.input :description
    end                               
    f.inputs "Job Details" do       
      f.input :start_date, :as => :datepicker
      f.input :end_date, :as => :datepicker 
      f.input :skills, :as => :check_boxes
    end
    

    f.inputs "Images" do       
      
      if f.object.content_images.any? 
        f.input :lead_image_id, :as => :select, :collection => f.object.content_images
      end
      
      f.has_many :content_images do |imgs_f|
        imgs_f.input :title
        imgs_f.input :picture, :as => :file, :hint => imgs_f.object.new_record? ? imgs_f.template.content_tag(:span, "No image uploaded") : imgs_f.template.image_tag(imgs_f.object.picture.url(:thumb))
      end
      
    end
    f.actions                         
  end
  
end
