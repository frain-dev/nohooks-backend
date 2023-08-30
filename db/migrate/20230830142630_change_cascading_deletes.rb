class ChangeCascadingDeletes < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :render_deployments, :render_services
    remove_foreign_key :notion_rows, :notion_databases
    add_foreign_key :render_deployments, :render_services, on_delete: :cascade
    add_foreign_key :notion_rows, :notion_databases, on_delete: :cascade
  end
end
