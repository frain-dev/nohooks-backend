class CreateDigitalOceanDroplets < ActiveRecord::Migration[7.0]
  def change
    create_table :digital_ocean_droplets, id: :uuid do |t|
      t.string :droplet_id, null: false
      t.string :object_hash, null: false
      t.references :accounts, foreign_key: true, type: :uuid

      t.index [:accounts_id, :droplet_id], unique: true

      t.timestamps
    end
  end
end
