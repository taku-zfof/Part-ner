# frozen_string_literal: true

class AddUserToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :user_id, :integer
  end
end
