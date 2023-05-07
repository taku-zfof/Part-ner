class AddPrefectureCodeToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :prefecture_code, :integer
  end
end
