class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.string :location
      t.string :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
