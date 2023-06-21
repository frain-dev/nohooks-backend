class ModifyRenderObjectReferences < ActiveRecord::Migration[7.0]
  def change
    rename_column :render_services, :render_account_id, :account_id 
  end
end
