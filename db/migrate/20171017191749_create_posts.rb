class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :raw, null: false
      t.string :title, null: false
      t.string :tags, array: true, null: false, default: []
      t.string :url, null: false
      t.string :aliases, array: true, null: false, default: []
      t.boolean :published, null: false, default: true
      t.timestamps
    end
  end
end
