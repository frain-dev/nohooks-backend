class CreateWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks, id: :uuid do |t|
      t.string :event_type, null: false
      t.json :payload, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
