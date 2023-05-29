# frozen_string_literal: true

class ChangeColumnsAddNotnullOnAll < ActiveRecord::Migration[6.1]
  def change
    change_column :chatrooms, :user_id, :integer, null: false
    change_column :chatrooms, :job_id, :integer, null: false
    change_column :chatrooms, :rondom_id, :string, null: false

    change_column :jobs, :user_id, :integer, null: false
    change_column :jobs, :hourly_wage, :integer, null: false
    change_column :jobs, :job_type, :integer, null: false
    change_column :jobs, :prefecture_code, :integer, null: false
    change_column :jobs, :rondom_id, :string, null: false

    change_column :messages, :chatroom_id, :integer, null: false
    change_column :messages, :user_id, :integer, null: false
    change_column :messages, :content, :text, null: false

    change_column :offers, :job_id, :integer, null: false
    change_column :offers, :user_id, :integer, null: false
    change_column :offers, :content, :text, null: false

    change_column :users, :account_name, :string, null: false
  end
end
