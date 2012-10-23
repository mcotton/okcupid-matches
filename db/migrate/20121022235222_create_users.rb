class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :is_male
      t.string :orientation
      t.boolean :is_matched
      t.string :matched_with

      t.timestamps
    end
  end
end
