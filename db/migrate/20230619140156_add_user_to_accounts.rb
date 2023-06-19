class AddUserToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :user, foreign_key: true, type: :uuid, null: false
  end
end
