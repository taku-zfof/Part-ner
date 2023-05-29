# frozen_string_literal: true

class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def change
    def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :users, :introduction, true
    end

  def down
    change_column_null :users, :introduction, false
  end
  end
end
