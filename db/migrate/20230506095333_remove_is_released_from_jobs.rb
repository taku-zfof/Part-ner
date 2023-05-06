class RemoveIsReleasedFromJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :is_released, :boolean
  end
end
