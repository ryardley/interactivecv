class AddLeadImageToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :lead_image_id, :integer
  end
end
