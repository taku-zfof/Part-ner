class AddRondomIdToChatrooms < ActiveRecord::Migration[6.1]
  def change
    add_column :chatrooms, :rondom_id, :string
  end
end
