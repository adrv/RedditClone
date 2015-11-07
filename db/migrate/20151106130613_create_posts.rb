class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :content
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
