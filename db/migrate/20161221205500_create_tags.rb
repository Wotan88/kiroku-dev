class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :label, unique: true, null: false, default: ""
      t.integer :count

      t.timestamps
    end
  end
end
