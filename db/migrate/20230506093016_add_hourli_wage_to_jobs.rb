class AddHourliWageToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :hourly_wage, :integer
    add_column :jobs, :latitude, :double
    add_column :jobs, :longitude, :double
    add_column :jobs, :released, :boolean
  end
end
