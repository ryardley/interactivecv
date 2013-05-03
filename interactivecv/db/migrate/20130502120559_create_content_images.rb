class CreateContentImages < ActiveRecord::Migration
  def change
    create_table :content_images do |t|
      t.string :title
      t.attachment :picture
      t.integer :job_id
      t.timestamps
    end
  end
end
