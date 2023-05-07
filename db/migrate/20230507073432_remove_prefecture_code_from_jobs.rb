class RemovePrefectureCodeFromJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :prefecture_code, :string
  end
end
