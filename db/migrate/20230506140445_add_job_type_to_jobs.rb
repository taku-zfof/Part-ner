class AddJobTypeToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :job_type, :integer
  end
end
