ActiveAdmin.register Skill do
  
  index do                            
    column :title
    column :group                            
    default_actions
  end
  
  form do |f|
    f.inputs "Skill Details" do                            
      f.input :title
      f.input :group
    end
    f.actions                         
  end  
end
