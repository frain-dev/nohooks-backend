class CreateRenderAccountConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :render_account_configurations, id: :uuid do |t|
      t.string :api_key, null: false

      t.timestamps
    end
  end
end
