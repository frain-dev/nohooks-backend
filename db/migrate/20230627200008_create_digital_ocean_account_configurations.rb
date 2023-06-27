class CreateDigitalOceanAccountConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :digital_ocean_account_configurations, id: :uuid do |t|
      t.string :access_token, null: false

      t.timestamps
    end
  end
end
