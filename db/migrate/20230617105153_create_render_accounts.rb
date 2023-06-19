class CreateRenderAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :render_accounts, id: :uuid do |t|
      t.string :name, null: false
      t.string :api_key, null: false
      t.datetime :last_poll_time, null: false

      t.index [:name, :api_key], unique: true

      t.timestamps
    end
  end
end
