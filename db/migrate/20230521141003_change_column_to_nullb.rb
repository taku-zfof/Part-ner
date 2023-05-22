class ChangeColumnToNullb < ActiveRecord::Migration[6.1]
  def change
    change_column_null :jobs, :hourly_wage, true
    change_column_null :jobs, :job_type, true
    change_column_null :jobs, :prefecture_code, true
  end
end
