# frozen_string_literal: true

class RemoveReleasedFromJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :released, :boolean
  end
end
