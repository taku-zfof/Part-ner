class ChangeColumnToNull2 < ActiveRecord::Migration[6.1]
  def change
    def up
    change_column :users, :introduction,:text, null: true 
  end

  def down
    change_column :users, :introduction,:text, null: false
  end

end