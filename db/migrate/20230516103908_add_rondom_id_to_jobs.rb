# frozen_string_literal: true

class AddRondomIdToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :rondom_id, :string
  end
end
