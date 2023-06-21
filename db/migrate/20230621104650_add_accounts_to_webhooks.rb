class AddAccountsToWebhooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :webhooks, :account, foreign_key: true, type: :uuid
  end
end
