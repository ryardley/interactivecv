ActiveAdmin.register ContentImage do
  menu  :parent => "Content",
        :label => "Images",
        :priority => 30
        
  config.clear_sidebar_sections!
  show do
    attributes_table do
      row :title
      row :image do
        link_to(image_tag(content_image.picture.url(:large)), edit_admin_content_image_path(content_image))
      end
    end
  end
  
  index :download_links => false  do                            
    # column :title
    column "Image" do |content_image|
      link_to(image_tag(content_image.picture.url(:thumb)), edit_admin_content_image_path(content_image))
    end                         
    default_actions
  end        
   
  form do |f|                         
    f.inputs "Image Asset" do       
      f.input :title
      f.input :picture, :as => :file,:hint => f.object.new_record? ? f.template.content_tag(:span, "No image uploaded") : f.template.image_tag(f.object.picture.url(:thumb))
    end          
    f.actions                         
  end  
end
