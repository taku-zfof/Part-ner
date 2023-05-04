class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :tytle, null: false
      t.integer :type, null: false
      t.text :introduction, null: false
      t.string :postal_code, null: false
      t.string :prefecture_code, null: false
      t.string :other_address, null: false
      t.string :near_station, null: false
      t.string :near_station_line, null: false
      t.boolean :is_released, null: false, default: false

      t.timestamps
    end
  end
end
