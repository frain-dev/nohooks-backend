class CreateWebhookSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :webhook_subscriptions, id: :uuid do |t|
      t.string :convoy_endpoint_id, null: false
      t.string :convoy_subscription_id, null: false

      t.timestamps
    end
  end
end
