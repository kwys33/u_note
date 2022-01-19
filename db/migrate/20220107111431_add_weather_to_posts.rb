class AddWeatherToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :weather, :string
  end
end
