class AddImageableToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :imageable, polymorphic: true, index: true
  end
end
