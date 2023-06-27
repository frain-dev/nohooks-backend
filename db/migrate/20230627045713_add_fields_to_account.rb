class AddFieldsToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :status, :integer, default: 0
    rename_column :accounts, :last_poll_time, :sync_start_datetime
  end
end
