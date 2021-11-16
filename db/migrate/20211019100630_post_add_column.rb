class PostAddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :when, :string
  end
end
