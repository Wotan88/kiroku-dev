class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :filename
      t.binary :attachment, null: false
      t.integer :mime, null: false, default: -1
      t.string :comment

      t.timestamps
    end
  end
end
