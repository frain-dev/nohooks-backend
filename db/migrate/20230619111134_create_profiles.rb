class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
