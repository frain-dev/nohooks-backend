class CreateRenderServices < ActiveRecord::Migration[7.0]
  def change
    create_table :render_services, id: :uuid do |t|
      t.string :service_id, null: false
      t.string :object_hash, null: false
      t.references :render_account, foreign_key: true, type: :uuid

      t.index :service_id, unique: true

      t.timestamps
    end
  end
end
