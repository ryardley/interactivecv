ActiveAdmin.register Job do
  
  index do                            
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
      f.input :skills
    end
    f.actions                         
  end
  
end
