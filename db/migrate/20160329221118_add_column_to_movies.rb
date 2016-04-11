class AddColumnToMovies < ActiveRecord::Migration
  def change
  	add_attachment :movies, :cover
  end
end
