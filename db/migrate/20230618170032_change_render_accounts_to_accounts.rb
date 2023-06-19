class ChangeRenderAccountsToAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_column :render_accounts, :api_key, :string
    rename_table :render_accounts, :accounts
    add_reference :accounts, :configurable, polymorphic: true, type: :uuid
  end
end
