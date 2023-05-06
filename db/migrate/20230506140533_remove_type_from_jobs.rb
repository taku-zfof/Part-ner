class RemoveTypeFromJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :type, :integer
  end
end
