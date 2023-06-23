class CreateNotionAccountConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :notion_account_configurations, id: :uuid do |t|
      t.string :access_token, null: false

      t.index :access_token
      t.timestamps
    end
  end
end
