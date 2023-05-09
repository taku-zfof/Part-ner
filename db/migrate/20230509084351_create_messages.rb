class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :chatroom_id
      t.integer :user_id
      t.text :content
      t.boolean :read_status, null: false, default: false

      t.timestamps
    end
  end
end
