class AddReleasedToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :released, :boolean, default: true, null: false
  end
end
