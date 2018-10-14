# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :short_url, null: false

      t.timestamps
    end
    add_index :links, :url, unique: true
    add_index :links, :short_url, unique: true
  end
end
