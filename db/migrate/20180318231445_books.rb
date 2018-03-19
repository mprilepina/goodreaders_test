class Books < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
	t.integer :book_id, null: false
	t.string :title, null: false
	t.string :author, null: false
	t.string :image_url, null: false
    end
  end
end
