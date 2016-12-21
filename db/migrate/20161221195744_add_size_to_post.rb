class AddSizeToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :width, :integer, null: false, default: -1
    add_column :posts, :height, :integer, null: false, default: -1
  end
end
