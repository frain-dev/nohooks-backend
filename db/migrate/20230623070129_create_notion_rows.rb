class CreateNotionRows < ActiveRecord::Migration[7.0]
  def change
    create_table :notion_rows, id: :uuid do |t|
      t.string :row_id
      t.string :object_hash, null: false
      t.references :notion_database, foreign_key: true, type: :uuid

      t.index [:notion_database_id, :row_id], unique: true

      t.timestamps
    end
  end
end
