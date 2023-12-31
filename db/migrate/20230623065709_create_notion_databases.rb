class CreateNotionDatabases < ActiveRecord::Migration[7.0]
  def change
    create_table :notion_databases, id: :uuid do |t|
      t.string :database_id, null: false
      t.references :account, foreign_key: true, type: :uuid

      t.index [:account_id, :database_id], unique: true,
              name: :unique_database_per_account

      t.timestamps
    end
  end
end
