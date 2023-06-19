class CreateRenderDeployments < ActiveRecord::Migration[7.0]
  def change
    create_table :render_deployments, id: :uuid do |t|
      t.string :deployment_id, null: false
      t.string :object_hash, null: false
      t.references :render_service, foreign_key: true, type: :uuid

      t.index :deployment_id, unique: true

      t.timestamps
    end
  end
end
