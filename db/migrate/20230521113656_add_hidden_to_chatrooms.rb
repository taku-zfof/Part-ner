# frozen_string_literal: true

class AddHiddenToChatrooms < ActiveRecord::Migration[6.1]
  def change
    add_column :chatrooms, :hidden, :boolean, default: false, null: false
  end
end
