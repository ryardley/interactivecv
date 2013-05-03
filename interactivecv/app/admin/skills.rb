ActiveAdmin.register Skill do
  
  menu  :parent => "Content",
        :label => "Skills"

  config.clear_sidebar_sections!
  
  index :download_links => false do                            
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
