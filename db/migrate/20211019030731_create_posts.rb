class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :memo
      t.integer :user_id
      t.date :date
      t.timestamps
    end
  end
end
