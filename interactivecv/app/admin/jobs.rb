ActiveAdmin.register Job do
  
  menu  :parent => "Data", 
        :label => "Jobs"
  
  index :download_links => false  do                            
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
      f.input :start_date
      f.input :end_date 
      f.input :skills, :as => :check_boxes
    end
    f.actions                         
  end
  
end
