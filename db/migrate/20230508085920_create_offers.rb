# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.integer :job_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
