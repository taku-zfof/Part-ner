# frozen_string_literal: true

class CreateChatrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chatrooms do |t|
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
