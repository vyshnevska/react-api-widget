class AddImagesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :top_image, :string
    add_column :posts, :image_1, :string
    add_column :posts, :image_2, :string
  end
end
