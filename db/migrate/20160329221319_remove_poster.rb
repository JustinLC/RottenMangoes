class RemovePoster < ActiveRecord::Migration
  def change
  	remove_column :movies, :poster_image_url
  end
end
